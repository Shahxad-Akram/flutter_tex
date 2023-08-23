import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  bool _ignoreRenderStartCallBack = false;

  double _height = minHeight;
  String? _lastData;
  bool _pageLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPage();
  }

  void loadPage() async {
    _controller.addJavaScriptChannel(
      "TeXViewRenderedCallback",
      onMessageReceived: renderCallback,
    );

    _controller.addJavaScriptChannel(
      "OnTapCallback",
      onMessageReceived: onTapCallback,
    );

    await _controller.loadFlutterAsset(
        "packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html");

    _pageLoaded = true;
    _initTeXView();
  }

  void renderCallback(jm) async {
    double height = double.parse(jm.message);
    if (_height != height) {
      setState(() {
        _height = height;
      });
    }

    widget.onRenderFinished?.call(height);
    _ignoreRenderStartCallBack = false;
  }

  void onTapCallback(jm) {
    widget.child.onTapCallback(jm.message);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    if (getRawData(widget) != _lastData) {
      widget.onRenderStarted?.call();
      _ignoreRenderStartCallBack = true;
    }
    return IndexedStack(
      index: widget.loadingWidgetBuilder?.call(context) != null
          ? _height == minHeight
              ? 1
              : 0
          : 0,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: WebViewWidget(controller: _controller),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? const SizedBox.shrink()
      ],
    );
  }

  void _initTeXView() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_pageLoaded && getRawData(widget) != _lastData) {
        if (widget.loadingWidgetBuilder != null) _height = minHeight;
        if (!_ignoreRenderStartCallBack) widget.onRenderStarted?.call();
        _controller.runJavaScript("initView(${getRawData(widget)})");
        _lastData = getRawData(widget);
      }
    });
  }
}
