import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_child.dart';
import 'package:flutter_tex/src/utils/flutter_tex_server.dart';
import 'package:webview_flutter/webview_flutter.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  final Key key;

  /// A list of TeXViewChild.
  @required
  final List<TeXViewChild> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  /// Render Engine to render TeX.
  final RenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// Show or hide loadingWidget.
  final bool showLoadingWidget;

  /// On Tap Callback when a TeXViewChild is tapped.
  final Function(String childID) onTap;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  TeXView(
      {this.key,
      this.children,
      this.style,
      this.height,
      this.loadingWidget,
      this.showLoadingWidget,
      this.onTap,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine})
      : super(key: key);

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewController _teXWebViewController;
  TeXViewServer _flutterTeXServer = TeXViewServer();
  double _teXViewHeight = 1;
  String lastTeXHTML;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _preBuild();
    return IndexedStack(
      index: widget.showLoadingWidget ? _teXViewHeight == 1 ? 1 : 0 : 0,
      children: <Widget>[
        Container(
          height: widget.height ?? _teXViewHeight,
          child: WebView(
            onPageFinished: _onPageFinished,
            onWebViewCreated: _onWebViewCreated,
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'RenderedTeXViewHeight',
                  onMessageReceived: _renderedTeXViewHeightHandler),
              JavascriptChannel(
                  name: 'TeXViewItemTapCallback',
                  onMessageReceived: _teXViewItemTapCallbackHandler),
            ]),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        widget.loadingWidget ??
            Center(
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
            )
      ],
    );
  }

  @override
  void dispose() {
    _flutterTeXServer.close();
    super.dispose();
  }

  String getJsonRawTeXHTML() {
    return jsonEncode({
      "children": widget.children.map((child) => child.toJson()).toList(),
      "style": widget.style?.initStyle()?.replaceAll("%", "%25")
    });
  }

  void handleRequest(HttpRequest request) {
    const theUrl = "http://localhost:5353/getRawTeXHTML";
    try {
      if (request.method == 'GET' &&
          request.requestedUri.toString() == theUrl) {
        request.response.write(getJsonRawTeXHTML());
      } else {}
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
  }

  @override
  void initState() {
    _flutterTeXServer.start(handleRequest);
    super.initState();
  }

  String _getTeXViewUrl() {
    String renderEngine =
        widget.renderingEngine == RenderingEngine.MathJax ? "mathjax" : "katex";
    return "http://localhost:5353/packages/flutter_tex/src/tex_libs/$renderEngine/index.html";
  }

  void _onPageFinished(message) {
    if (widget.onPageFinished != null) {
      widget.onPageFinished(message);
    }
  }

  void _onWebViewCreated(WebViewController controller) {
    _teXWebViewController = controller;
    _teXWebViewController.loadUrl(_getTeXViewUrl());
  }

  void _preBuild() {
    if (_teXWebViewController != null && getJsonRawTeXHTML() != lastTeXHTML) {
      if (widget.showLoadingWidget) {
        _teXViewHeight = 1;
      }
      _teXWebViewController.loadUrl(_getTeXViewUrl());
      this.lastTeXHTML = getJsonRawTeXHTML();
    }
  }

  void _renderedTeXViewHeightHandler(JavascriptMessage javascriptMessage) {
    double viewHeight = double.parse(javascriptMessage.message) +
        (widget.renderingEngine == RenderingEngine.Katex ? 20 : 0);
    if (_teXViewHeight != viewHeight) {
      _teXViewHeight = viewHeight;

      setState(() {
        _teXViewHeight = viewHeight;
      });
    }
    if (widget.onRenderFinished != null) {
      widget.onRenderFinished(_teXViewHeight);
    }
  }

  void _teXViewItemTapCallbackHandler(JavascriptMessage javascriptMessage) {
    if (widget.onTap != null) {
      widget.onTap(javascriptMessage.message);
    }
  }
}
