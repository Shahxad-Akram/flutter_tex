import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewPlusController? _controller;

  static const double minH = 1;

  double _height = minH;
  String? _lastData;
  bool _pageLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _buildTeXView();
    return IndexedStack(
      index: widget.loadingWidgetBuilder?.call(context) != null
          ? _height == minH
              ? 1
              : 0
          : 0,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: WebViewPlus(
            onPageFinished: (message) {
              _pageLoaded = true;
              _buildTeXView();
            },
            initialUrl:
                "packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html",
            onWebViewCreated: (controller) {
              this._controller = controller;
            },
            javascriptChannels: jsChannels(),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? SizedBox.shrink()
      ],
    );
  }

  Set<JavascriptChannel> jsChannels() {
    return Set.from([
      JavascriptChannel(
          name: 'TeXViewRenderedCallback',
          onMessageReceived: (_) async {
            double height = await _controller!.getHeight();
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
      if (widget.loadingWidgetBuilder != null) _height = minH;
      _controller!.webViewController.evaluateJavascript(
          "var jsonData = " + getRawData(widget) + ";initView(jsonData);");
      this._lastData = getRawData(widget);
    }
  }
}
