library flutter_tex;

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

class TeXView extends StatefulWidget {
  final String teXHTML;
  final Key key;

  TeXView({this.key, this.teXHTML});

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> {
  _Server server = _Server();

  @override
  Widget build(BuildContext context) {
    server.start();
    return WebView(
        key: widget.key,
        initialUrl:
            "http://localhost:8080/packages/flutter_tex/MathJax/index.html?data=${widget.teXHTML}",
        javascriptMode: JavascriptMode.unrestricted);
  }

  @override
  void dispose() {
    server.close();
    super.dispose();
  }
}

class _Server {
  // class from inAppBrowser

  HttpServer _server;

  int _port = 8080;

  _Server({int port = 8080}) {
    this._port = port;
  }

  Future<void> start() async {
    if (this._server != null) {
      throw Exception('Server already started on http://localhost:$_port');
    }

    var completer = new Completer();

    runZoned(() {
      HttpServer.bind('127.0.0.1', _port).then((server) {
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

  ///Closes the server.
  Future<void> close() async {
    if (this._server != null) {
      await this._server.close(force: true);
      print('Server running on http://localhost:$_port closed');
      this._server = null;
    }
  }
}
