import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/views/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewPlusController _controller;
  double _height = 1;
  String _lastData;
  String _lastRenderingEngine;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _buildTeXView();
    return IndexedStack(
      index: widget.showLoadingWidget ? _height == 1 ? 1 : 0 : 0,
      children: <Widget>[
        SizedBox(
          height: widget.height ?? _height,
          child: WebViewPlus(
            onPageFinished: widget.onPageFinished,
            onWebViewCreated: (controller) {
              this._controller = controller;
              _buildTeXView();
            },
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'RenderedTeXViewHeight',
                  onMessageReceived: _renderedTeXViewHeightHandler),
              JavascriptChannel(
                  name: 'OnTapCallback',
                  onMessageReceived: (jm) {
                    widget.child.onTapManager(jm.message);
                  }),
              JavascriptChannel(
                  name: 'LoadData',
                  onMessageReceived: (_) {
                    _controller.evaluateJavascript("var jsonData = " +
                        getJsonData() +
                        ";initView(jsonData);");
                  })
            ]),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        widget.loadingWidget ?? _defaultLoadingWidget()
      ],
    );
  }

  String getJsonData() {
    return CoreUtils.getRawData(widget);
  }

  void _buildTeXView() {
    if (_controller != null &&
        (getJsonData() != _lastData ||
            widget.renderingEngine.getEngineName() != _lastRenderingEngine)) {
      if (widget.showLoadingWidget) _height = 1;
      _controller.loadAsset(
          "packages/flutter_tex/js/${widget.renderingEngine?.getEngineName()}/index.html");
      this._lastData = getJsonData();
      this._lastRenderingEngine = widget.renderingEngine.getEngineName();
    }
  }

  Widget _defaultLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Text("Rendering TeXView...!")
        ],
      ),
    );
  }

  void _renderedTeXViewHeightHandler(_) async {
    double height = double.parse(
        await _controller.evaluateJavascript('getTeXViewHeight()'));
    if (this._height != height)
      setState(() {
        this._height = height;
      });
    widget.onRenderFinished?.call(height);
  }
}
