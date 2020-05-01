import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:mime/mime.dart';
import 'package:webview_flutter/webview_flutter.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  final Key key;

  ///Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String teXHTML;

  /// Style TeXView with CSS code.
  final String style;

  /// Render Engine to render TeX.
  final RenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// On Tap Callback.
  final Function onTap;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  TeXView(
      {this.key,
      this.teXHTML,
      this.style,
      this.height,
      this.loadingWidget,
      this.onTap,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine})
      : super(key: key);

/*
  TeXView.multipleChoiceQuestion(
      {this.key,
      this.renderingEngine,
      this.height,
      this.loadingWidget,
      this.onRenderFinished,
      this.onPageFinished,
      this.keepAlive})
      : this.teXHTML = null,
        this.onTap = null,
        super(key: key);*/

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewServer {
  // class from inAppBrowser
  HttpServer _teXViewServer;
  int _port = 5353;

  ///Closes the server.
  Future<void> close() async {
    if (this._teXViewServer != null) {
      await this._teXViewServer.close(force: true);
      print('Server running on http://localhost:$_port closed');
      this._teXViewServer = null;
    }
  }

  ///Starts the server
  Future<void> start() async {
    if (this._teXViewServer != null) {
      throw Exception('Server already started on http://localhost:$_port');
    }

    var completer = new Completer();

    runZoned(() {
      HttpServer.bind('127.0.0.1', _port, shared: true).then((server) {
        print('Server running on http://localhost:' + _port.toString());

        this._teXViewServer = server;

        server.listen((HttpRequest request) async {
          var body = List<int>();
          var path = request.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';

          try {
            body = (await rootBundle.load(path)).buffer.asUint8List();
          } catch (e) {
            //    print(e.toString());
            request.response.close();
            return;
          }

          var contentType = ['text', 'html'];
          if (!request.requestedUri.path.endsWith('/') &&
              request.requestedUri.pathSegments.isNotEmpty) {
            var mimeType =
                lookupMimeType(request.requestedUri.path, headerBytes: body);
            if (mimeType != null) {
              contentType = mimeType.split('/');
            }
          }

          request.response.headers.contentType =
              new ContentType(contentType[0], contentType[1], charset: 'utf-8');
          request.response.add(body);
          request.response.close();
        });
        completer.complete();
      });
    }, onError: (e, stackTrace) => print('Error: $e $stackTrace'));
    return completer.future;
  }
}

class _TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewController _teXWebViewController;
  _TeXViewServer _teXViewServer = _TeXViewServer();
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
      index: _teXViewHeight == 1 ? 1 : 0,
      children: <Widget>[
        SizedBox(
          height: widget.height ?? _teXViewHeight,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: WebView(
                  onPageFinished: _onPageFinished,
                  onWebViewCreated: _onWebViewCreated,
                  javascriptChannels: Set.from([
                    JavascriptChannel(
                        name: 'RenderedTeXViewHeight',
                        onMessageReceived: _renderedTeXViewHeightHandler),
                    JavascriptChannel(
                        name: 'TeXViewItemTapCallback',
                        onMessageReceived: _renderedTeXViewHeightHandler),
                  ]),
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              Positioned.fill(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                      ))),
            ],
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
    _teXViewServer.close();
    super.dispose();
  }

  String _getTeXViewUrl() {
    String renderEngine =
        widget.renderingEngine == RenderingEngine.MathJax ? "mathjax" : "katex";
    String _teXHTML = """
       <style>
       #tex-view {
           ${widget.style}
       }
       </style>
       <div id='tex-view'>
       ${widget.teXHTML}
       </div>
    """;

    return "http://localhost:5353/packages/flutter_tex/src/tex_libs/$renderEngine/index.html?rawTeXHTML=${Uri.encodeComponent(jsonEncode({
      "teXHTML": _teXHTML,
    }))}";
  }

  @override
  void initState() {
    _teXViewServer.start();
    super.initState();
  }

  void _preBuild() {
    if (_teXWebViewController != null && widget.teXHTML != lastTeXHTML) {
      _teXViewHeight = 1;
      _teXWebViewController.loadUrl(_getTeXViewUrl());
      this.lastTeXHTML = widget.teXHTML;
    }
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
}
