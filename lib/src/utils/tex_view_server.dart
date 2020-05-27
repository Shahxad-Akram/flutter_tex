import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

class TeXViewServer {
  HttpServer _httpServer;
  HttpServer _webSocketServer;
  final int _httpServerPort;
  final int _webSocketServerPort;

  TeXViewServer(this._httpServerPort)
      : this._webSocketServerPort = _httpServerPort * 10;

  ///Closes the server.
  Future<void> close() async {
    if (this._webSocketServer != null) {
      await this._webSocketServer.close(force: true);
      print('Server running on http://localhost:$_webSocketServerPort closed');
      this._webSocketServer = null;
    }
    if (this._httpServer != null) {
      await this._httpServer.close(force: true);
      print('Server running on http://localhost:$_httpServerPort closed');
      this._httpServer = null;
    }
  }

  ///Starts the server
  Future<void> start(
      Function(HttpRequest request)
          requestCallback /*,
      Function(WebSocket webSocket) webSocketCallback*/
      ) async {
    if (this._httpServer != null) {
      throw Exception(
          'Server already started on http://localhost:$_httpServerPort');
    }
    var completer = new Completer();
    runZoned(() {
      /* HttpServer.bind('localhost', _webSocketServerPort, shared: true).then(
          (HttpServer webSocketServer) {
        this._webSocketServer = webSocketServer;
        print(
            '[+]WebSocket listening at -- ws://localhost:$_webSocketServerPort');
        webSocketServer.listen((HttpRequest request) {
          WebSocketTransformer.upgrade(request).then(webSocketCallback,
              onError: (err) => print('[!]Error -- ${err.toString()}'));
        }, onError: (err) => print('[!]Error -- ${err.toString()}'));
      }, onError: (err) => print('[!]Error -- ${err.toString()}')).then(
          (value) => */
      HttpServer.bind('localhost', _httpServerPort, shared: true)
          .then((server) {
        print(
            'Server running on http://localhost:' + _httpServerPort.toString());
        this._httpServer = server;
        server.listen((HttpRequest httpRequest) async {
          requestCallback(httpRequest);
          var body = List<int>();
          var path = httpRequest.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';
          try {
            body = (await rootBundle.load(path)).buffer.asUint8List();
          } catch (e) {
            print(e.toString());
            httpRequest.response.close();
            return;
          }
          var contentType = ['text', 'html'];
          if (!httpRequest.requestedUri.path.endsWith('/') &&
              httpRequest.requestedUri.pathSegments.isNotEmpty) {
            var mimeType = lookupMimeType(httpRequest.requestedUri.path,
                headerBytes: body);
            if (mimeType != null) {
              contentType = mimeType.split('/');
            }
          }
          httpRequest.response.headers.contentType =
              new ContentType(contentType[0], contentType[1], charset: 'utf-8');
          httpRequest.response.add(body);
          httpRequest.response.close();
        });
        completer.complete();
      }) /*)*/;
    }, onError: (e, stackTrace) => print('[!]Error -- $e $stackTrace'));
    return completer.future;
  }
}
