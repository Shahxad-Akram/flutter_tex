import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/views/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  static int instanceCount = 0;
  WebViewPlusController _controller;
  double _height = 1;
  String _lastData;
  String _lastRenderingEngine;

  TeXViewState() {
    instanceCount += 1;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return IndexedStack(
      index: widget.showLoadingWidget ? _height == 1 ? 1 : 0 : 0,
      children: <Widget>[
        AnimatedSize(
          vsync: this,
          curve: Curves.easeInSine,
          duration: Duration(milliseconds: 1),
          child: SizedBox(
            height: widget.height ?? _height,
            child: WebViewPlus(
              onPageFinished: widget.onPageFinished,
              onWebViewCreated: (controller) {
                this._controller = controller;
                _initTeXView();
              },
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'RenderedTeXViewHeight',
                    onMessageReceived: _renderedTeXViewHeightHandler),
                JavascriptChannel(
                    name: 'OnTapCallback',
                    onMessageReceived: (javascriptMessage) {
                      widget.child.onTapManager(javascriptMessage.message);
                    }),
              ]),
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
        widget.loadingWidget ?? _defaultLoadingWidget()
      ],
    );
  }

  @override
  void dispose() {
    instanceCount -= 1;
    super.dispose();
  }

  String getJsonData() {
    return CoreUtils.getRawData(widget);
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

  void _initTeXView() {
    if (_controller != null &&
        (getJsonData() != _lastData ||
            widget.renderingEngine.getEngineName() != _lastRenderingEngine)) {
      if (widget.showLoadingWidget) _height = 1;
      _controller.loadAsset(
          "packages/flutter_tex/js/${widget.renderingEngine?.getEngineName()}/index.html?instanceCount=$instanceCount",
          codeInjections: <CodeInjection>[
            CodeInjection(
                from: '//||||||||||JSON||DATA||HERE||||||||||',
                to: "var jsonData = " + getJsonData())
          ]);
      this._lastData = getJsonData();
      this._lastRenderingEngine = widget.renderingEngine.getEngineName();
    }
  }

  void _renderedTeXViewHeightHandler(JavascriptMessage javascriptMessage) {
    double viewHeight = double.parse(javascriptMessage.message);
    if (this._height != viewHeight)
      setState(() {
        this._height = viewHeight;
      });

    if (widget.onRenderFinished != null) widget.onRenderFinished(this._height);
  }
}
