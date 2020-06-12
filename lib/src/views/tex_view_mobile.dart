import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/tex_view_server.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewController _controller;
  double _height = 1;
  String _lastData;
  bool _pageLoaded = false;

  TeXViewState() {
    TeXViewServer.start();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _buildTeXView();
    return IndexedStack(
      index: widget.loadingWidgetBuilder?.call(context) != null
          ? _height == 1 ? 1 : 0
          : 0,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: WebView(
            initialUrl:
                "http://localhost:5353/packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html",
            onWebViewCreated: (controller) {
              this._controller = controller;
            },
            onPageFinished: (message) {
              _pageLoaded = true;
              _buildTeXView();
            },
            javascriptChannels: jsChannels(),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? SizedBox.shrink()
      ],
    );
  }

  @override
  void dispose() {
    TeXViewServer.start();
    super.dispose();
  }

  Set<JavascriptChannel> jsChannels() {
    return Set.from([
      JavascriptChannel(
          name: 'TeXViewRenderedCallback',
          onMessageReceived: (_) async {
            double height = double.parse(
                await _controller.evaluateJavascript('getTeXViewHeight()'));
            if (this._height != height)
              setState(() {
                this._height = height;
              });
            widget.onRenderFinished?.call(height);
          }),
      JavascriptChannel(
          name: 'OnTapCallback',
          onMessageReceived: (jm) {
            widget.child.onTapManager(jm.message);
          })
    ]);
  }

  void _buildTeXView() {
    if (_pageLoaded && _controller != null && getRawData(widget) != _lastData) {
      if (widget.loadingWidgetBuilder != null) _height = 1;
      _controller.evaluateJavascript(
          "var jsonData = " + getRawData(widget) + ";initView(jsonData);");
      this._lastData = getRawData(widget);
    }
  }
}
