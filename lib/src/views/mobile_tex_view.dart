import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/utils/tex_view_server.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  static int instanceCount = 0;
  WebViewController _teXWebViewController;
  int _port = 5353 + instanceCount;
  TeXViewServer _flutterTeXServer;
  double _teXViewHeight = 1;
  String _lastTeXHTML;
  String _lastRenderingEngine;

  TeXViewState() {
    _flutterTeXServer = TeXViewServer(_port);
    instanceCount += 1;
    _flutterTeXServer.start(handleRequest);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
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
                  name: 'TeXViewChildTapCallback',
                  onMessageReceived: _teXViewChildTapCallbackHandler),
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
    instanceCount -= 1;
    super.dispose();
  }

  String getJsonRawTeXHTML() {
    return jsonEncode({
      'meta': TeXViewWidgetMeta(tag: 'div', type: 'tex-view', node: Node.Root)
          .toJson(),
      'id': null,
      'data': widget.children.map((child) => child.toJson()).toList(),
      'style': widget.style?.initStyle() ?? teXViewDefaultStyle
    });
  }

  void handleRequest(HttpRequest request) {
    try {
      if (request.method == 'GET' &&
          request.uri.queryParameters['query'] == "getRawTeXHTML") {
        request.response.write(getJsonRawTeXHTML());
      } else {}
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
  }

  String _getTeXViewUrl() {
    String baseUri =
        "http://localhost:$_port/packages/flutter_tex/src/flutter_tex_libs/${widget.renderingEngine?.getEngineName()}/index.html?port=$_port&instanceCount=$instanceCount&configurations=${Uri.encodeComponent(widget.renderingEngine?.getConfigurations())}";
    String rawTeXHTMLUri =
        "http://localhost:$_port/packages/flutter_tex/src/flutter_tex_libs/${widget.renderingEngine?.getEngineName()}/index.html?port=$_port&instanceCount=$instanceCount&configurations=${widget.renderingEngine?.getConfigurations()}&urlRawTeXHTML=${Uri.encodeComponent(getJsonRawTeXHTML())}";

    return rawTeXHTMLUri.length < 2048 ? rawTeXHTMLUri : baseUri;
  }

  void _initTeXView() {
    if (_teXWebViewController != null &&
        (getJsonRawTeXHTML() != _lastTeXHTML ||
            widget.renderingEngine.getEngineName() != _lastRenderingEngine)) {
      if (widget.showLoadingWidget) {
        _teXViewHeight = 1;
      }
      _teXWebViewController.loadUrl(_getTeXViewUrl());
      this._lastTeXHTML = getJsonRawTeXHTML();
      this._lastRenderingEngine = widget.renderingEngine.getEngineName();
    }
  }

  void _onPageFinished(message) {
    if (widget.onPageFinished != null) {
      widget.onPageFinished(message);
    }
  }

  void _onWebViewCreated(WebViewController controller) {
    _teXWebViewController = controller;
    _initTeXView();
  }

  void _renderedTeXViewHeightHandler(JavascriptMessage javascriptMessage) {
    double viewHeight = double.parse(javascriptMessage.message);
    if (_teXViewHeight != viewHeight) {
      setState(() {
        _teXViewHeight = viewHeight;
      });
    }
    if (widget.onRenderFinished != null) {
      widget.onRenderFinished(_teXViewHeight);
    }
  }

  void _teXViewChildTapCallbackHandler(JavascriptMessage javascriptMessage) {
    if (widget.onTap != null) {
      widget.onTap(javascriptMessage.message);
    }
  }
}
