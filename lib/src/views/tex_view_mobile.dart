import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
 // WebViewPlusController? _controller;
  WebViewController? _controller;

  double _height = minHeight;
  String? _lastData;
  bool _pageLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _buildTeXView();
    return IndexedStack(
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
            //initialUrl: "",
            onWebViewCreated: (controller) {
              this._controller = controller;
              controller.loadFlutterAsset('packages/flutter_tex/assets/js/${widget.renderingEngine?.name ?? 'katex'}/index.html');
            },
            javascriptChannels: jsChannels(),
            javascriptMode: JavascriptMode.unrestricted,
            backgroundColor: Colors.transparent,
          ),


          // WebViewPlus(
          //   onPageFinished: (message) {
          //     _pageLoaded = true;
          //     _buildTeXView();
          //   },
          //   initialUrl:
          //       "packages/flutter_tex/js/${widget.renderingEngine?.name ?? 'katex'}/index.html",
          //   onWebViewCreated: (controller) {
          //     this._controller = controller;
          //   },
          //   javascriptChannels: jsChannels(),
          //   javascriptMode: JavascriptMode.unrestricted,
          // ),
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
            double height =  await getHeight();
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

  Future<double> getHeight() async {
    String getHeightScript = r"""
        getWebviewFlutterPlusHeight();
        function getWebviewFlutterPlusHeight() {
            var element = document.body;
            var height = element.offsetHeight,
                style = window.getComputedStyle(element)
            return ['top', 'bottom']
                .map(function (side) {
                    return parseInt(style["margin-" + side]);
                })
                .reduce(function (total, side) {
                    return total + side;
                }, height)
              }""";
    return double.parse(
        await _controller!.runJavascriptReturningResult(getHeightScript));
  }

  void _buildTeXView() {
    if (_pageLoaded && _controller != null && getRawData(widget) != _lastData) {
      if (widget.loadingWidgetBuilder != null) _height = minHeight;
      _controller!.runJavascript(
          "var jsonData = " + getRawData(widget) + ";initView(jsonData);");
      this._lastData = getRawData(widget);
    }
  }
}
