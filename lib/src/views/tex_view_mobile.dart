import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/server.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewController? _controller;

  double _height = minHeight;
  String? _lastData;
  bool _pageLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _buildTeXView();

    return FutureBuilder(
      future: TeXServer.start(),
      builder: (BuildContext context, AsyncSnapshot<int> snap) {
        return snap.hasData && !snap.hasError
            ? IndexedStack(
                index: widget.loadingWidgetBuilder?.call(context) != null
                    ? _height == minHeight
                        ? 1
                        : 0
                    : 0,
                children: <Widget>[
                  SizedBox(
                    height: _height,
                    child: WebView(
                      onPageFinished: (message) {
                        _pageLoaded = true;
                        _buildTeXView();
                      },
                      initialUrl:
                          "http://localhost:${snap.data}/packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html",
                      onWebViewCreated: (controller) {
                        _controller = controller;
                      },
                      backgroundColor: Colors.transparent,
                      allowsInlineMediaPlayback: true,
                      javascriptChannels: jsChannels(),
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                  widget.loadingWidgetBuilder?.call(context) ??
                      const SizedBox.shrink()
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    TeXServer.close();
    super.dispose();
  }

  Set<JavascriptChannel> jsChannels() {
    return {
      JavascriptChannel(
          name: 'TeXViewRenderedCallback',
          onMessageReceived: (jm) async {
            double height = double.parse(jm.message);
            if (_height != height) {
              setState(() {
                _height = height;
              });
            }
            widget.onRenderFinished?.call(height);
          }),
      JavascriptChannel(
          name: 'OnTapCallback',
          onMessageReceived: (jm) {
            widget.child.onTapManager(jm.message);
          })
    };
  }

  void _buildTeXView() {
    if (_pageLoaded && _controller != null && getRawData(widget) != _lastData) {
      if (widget.loadingWidgetBuilder != null) _height = minHeight;
      _controller!.runJavascript(
          "var jsonData = " + getRawData(widget) + ";initView(jsonData);");
      _lastData = getRawData(widget);
    }
  }
}
