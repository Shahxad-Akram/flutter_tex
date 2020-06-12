import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

class TeXViewServer {
  static HttpServer _server;

  ///Closes the server.
  static Future<void> close() async {
    if (_server != null) {
      await _server.close(force: true);
      //  print('Server running on http://localhost:$_port closed');
      _server = null;
    }
  }

  ///Starts the server
  static Future<void> start() async {
    var completer = new Completer();
    runZoned(() {
      HttpServer.bind('localhost', 5353, shared: true).then((server) {
        //   print('Server running on http://localhost:' + _port.toString());
        _server = server;
        server.listen((HttpRequest httpRequest) async {
          var body = List<int>();
          var path = httpRequest.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';
          try {
            body = (await rootBundle.load(path)).buffer.asUint8List();
          } catch (e) {
            print('Error: $e');
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
      });
    }, onError: (e, stackTrace) => print('Error: $e $stackTrace'));
    return completer.future;
  }
}
