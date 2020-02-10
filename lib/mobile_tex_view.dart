library flutter_tex;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:mime/mime.dart';
import 'package:webview_flutter/webview_flutter.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
///
///
class TeXView extends StatefulWidget {
  final Key key;

  ///Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String teXHTML;

  /// Render Engine to render TeX.
  final RenderingEngine renderingEngine;

  /// Fixed Height for TeXView.
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  TeXView(
      {this.key,
      this.teXHTML,
      this.height,
      this.loadingWidget,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine});

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  WebViewController _webViewController;
  _Server _server = _Server();
  double _height = 1;
  String oldTeXHTML;
  String baseUrl;

  @override
  void initState() {
    String renderEngine =
        widget.renderingEngine == RenderingEngine.MathJax ? "MathJax" : "Katex";

    baseUrl =
        "http://localhost:8080/packages/flutter_tex/$renderEngine/index.html";
    _server.start();
    super.initState();
  }

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();

    if (_webViewController != null && widget.teXHTML != oldTeXHTML) {
      _webViewController
          .loadUrl("$baseUrl?teXHTML=${Uri.encodeComponent(widget.teXHTML)}");
      this.oldTeXHTML = widget.teXHTML;
    }

    return IndexedStack(
      index: _height == 1 ? 1 : 0,
      children: <Widget>[
        SizedBox(
          height: widget.height ?? _height,
          child: WebView(
            key: widget.key,
            onPageFinished: (message) {
              if (widget.onPageFinished != null) {
                widget.onPageFinished(message);
              }
            },
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _webViewController.loadUrl(
                  "$baseUrl?teXHTML=${Uri.encodeComponent(widget.teXHTML)}");
            },
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'RenderedWebViewHeight',
                  onMessageReceived: (JavascriptMessage message) {
                    double viewHeight = double.parse(message.message) + 20;

                    if (_height != viewHeight) {
                      setState(() {
                        _height = viewHeight;
                      });
                    }
                    if (widget.onRenderFinished != null) {
                      widget.onRenderFinished(_height);
                    }
                  })
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
                  SizedBox(
                    height: 5,
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
    _server.close();
    super.dispose();
  }
}

class _Server {
  // class from inAppBrowser

  HttpServer _server;
  int _port = 8080;

  ///Closes the server.
  Future<void> close() async {
    if (this._server != null) {
      await this._server.close(force: true);
      print('Server running on http://localhost:$_port closed');
      this._server = null;
    }
  }

  ///Starts the server
  Future<void> start() async {
    if (this._server != null) {
      throw Exception('Server already started on http://localhost:$_port');
    }

    var completer = new Completer();

    runZoned(() {
      HttpServer.bind('127.0.0.1', _port, shared: true).then((server) {
        print('Server running on http://localhost:' + _port.toString());

        this._server = server;

        server.listen((HttpRequest request) async {
          var body = List<int>();
          var path = request.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';

          try {
            body = (await rootBundle.load(path)).buffer.asUint8List();
          } catch (e) {
            print(e.toString());
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
