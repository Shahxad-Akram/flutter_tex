import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  late WebViewControllerPlus _controller;

  double _height = minHeight;
  String? _lastData;
  bool _pageLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(Colors.transparent.value))
      ..loadFlutterAssetServer(
          "packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html")
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _pageLoaded = true;
            _initTeXView();
          },
        ),
      )
      ..setOnConsoleMessage((message) {
        if (kDebugMode) {
          print(message);
        }
      })
      ..addJavaScriptChannel('OnTapCallback', onMessageReceived: (jm) {
        widget.child.onTapCallback(jm.message);
      })
      ..addJavaScriptChannel('TeXViewRenderedCallback',
          onMessageReceived: (jm) async {
        double height = double.parse(jm.message);
        if (_height != height) {
          setState(() {
            _height = height;
          });
        }
        widget.onRenderFinished?.call(height);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return IndexedStack(
      index: widget.loadingWidgetBuilder?.call(context) != null
          ? _height == minHeight
              ? 1
              : 0
          : 0,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? const SizedBox.shrink()
      ],
    );
  }

  @override
  void dispose() {
    _controller.server.close();
    super.dispose();
  }

  void _initTeXView() {
    if (_pageLoaded && getRawData(widget) != _lastData) {
      if (widget.loadingWidgetBuilder != null) _height = minHeight;
      _controller
          .runJavaScriptReturningResult("initView(${getRawData(widget)})");
      _lastData = getRawData(widget);
    }
  }
}
