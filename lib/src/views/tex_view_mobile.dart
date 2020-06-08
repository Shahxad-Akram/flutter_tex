import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/views/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewPlusController _controller;
  double _height = 1;
  String _lastData;
  bool _isPageLoaded = false;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

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
          child: WebViewPlus(
            onWebViewCreated: (controller) {
              this._controller = controller
                ..loadAsset(
                    "packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html");
            },
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'TeXViewRenderedCallback',
                  onMessageReceived: _renderedTeXViewHeightHandler),
              JavascriptChannel(
                  name: 'OnTapCallback',
                  onMessageReceived: (jm) {
                    widget.child.onTapManager(jm.message);
                  }),
              JavascriptChannel(
                  name: 'TeXViewCreatedCallback',
                  onMessageReceived: (_) {
                    widget.onTeXViewCreated?.call(
                        TeXViewController._(controller: this._controller));
                    _isPageLoaded = true;
                    _buildTeXView();
                  })
            ]),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? SizedBox.shrink()
      ],
    );
  }


  void _buildTeXView() {
    if (_isPageLoaded && _controller != null &&
        getRawData(widget) != _lastData) {
      if (widget.loadingWidgetBuilder != null) _height = 1;
      _controller.evaluateJavascript("var jsonData = " +
          getRawData(widget) +
          ";initView(jsonData);");
      this._lastData = getRawData(widget);
    }
  }

  void _renderedTeXViewHeightHandler(_) async {
    double height = double.parse(
        await _controller.evaluateJavascript('getTeXViewHeight()'));
    if (this._height != height) setState(() {
      this._height = height;
    });
    widget.onRenderFinished?.call(height);
  }
}


class TeXViewController {

  final WebViewPlusController _controller;

  TeXViewController._({WebViewPlusController controller})
      :_controller=controller;

  Future<String> loadCode() {
    return Future<String>.value(
        _controller.evaluateJavascript("javascriptString"));
  }

}
