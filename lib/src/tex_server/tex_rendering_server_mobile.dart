import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/globals.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_cache.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_queue.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

/// The standard (Mobile/Desktop) implementation of [TeXRenderingServer].
///
/// This server uses a hidden [WebViewControllerPlus] (WebView) to load a local HTML file
/// containing the MathJax library. It communicates via JavaScript channels to render TeX to SVG.
///
/// Key Features:
/// - **Localhost Server**: Serves the engine files locally.
/// - **LIFO Queue**: Prioritizes visible items during rapid scrolling.
/// - **LRU Cache**: Caches rendered SVGs to minimize repeated render calls.
class TeXRenderingServer {
  static final LocalhostServer _server = LocalhostServer();
  static final TeXRenderingController teXRenderingController =
      TeXRenderingController();

  static int? get port => _server.port;
  static bool multiTeXView = false;

  // Cap concurrency to prevent platform channel saturation across simultaneous renders.
  static final TexRenderingQueue _queue =
      TexRenderingQueue(maxConcurrentRequests: 3);

  static Future<void> start({int port = 0}) async {
    await _server.start(port: port);
    await teXRenderingController.initController();
  }

  /// Synchronous cache check for the Widget.
  /// This allows widgets to build immediately if the SVG is already in memory.
  static String? getCachedSVG(String math, MathInputType type) {
    return TexRenderingCache.getCachedSVG(math, type);
  }

  /// Converts a TeX string to an SVG image.
  ///
  /// This method orchestrates:
  /// 1. **Cache Lookup**: Returns immediately if found.
  /// 2. **Deduplication**: Joins an existing in-flight request if one exists.
  /// 3. **Queueing**: Adds the task to a LIFO queue to be processed by the WebView.
  static TexRenderingRequest math2SVG({
    required String math,
    required MathInputType mathInputType,
  }) {
    return TexRenderingCache.render(
      math: math,
      mathInputType: mathInputType,
      onMissing: () {
        return _queue.addRequest(
            math: math,
            inputType: mathInputType,
            processor: () async {
              final data = await teXRenderingController.webViewControllerPlus
                  .runJavaScriptReturningResult(
                      "$mathJaxFlutterTeXLiteDOMMath2SVGChannelLabel(${jsonEncode(math)}, '${mathInputType.type}');");
              final String rawData = data.toString();
              String svg = rawData;

              try {
                if (rawData.startsWith('"') && rawData.endsWith('"')) {
                  final dynamic decoded = jsonDecode(rawData);
                  if (decoded is String) {
                    svg = decoded;
                  }
                }
              } catch (_) {
                svg = rawData;
              }

              return svg;
            });
      },
    );
  }

  static Future<void> stop() async {
    await _server.close();
  }
}

/// A controller for the WebView that handles TeX rendering.
class TeXRenderingController {
  final WebViewControllerPlus webViewControllerPlus = WebViewControllerPlus();

  /// The base URL for the rendering engine's HTML file, served by the localhost server.
  final String baseUrl =
      "http://localhost:${TeXRenderingServer.port!}/packages/flutter_tex/core/flutter_tex.html";

  /// Callback triggered when the WebView finishes loading a page.
  RenderingControllerCallback? onPageFinishedCallback;

  /// Callback triggered when a tap event occurs within the rendered TeX content.
  RenderingControllerCallback? onTapCallback;

  /// Callback triggered when the TeX view has finished rendering.
  RenderingControllerCallback? onTeXViewRenderedCallback;

  /// Initializes the [WebViewControllerPlus].
  ///
  /// This sets up JavaScript channels for communication, a navigation delegate
  /// to handle URL requests, and loads the initial rendering page.
  /// It returns a future that completes with the initialized controller.
  Future<WebViewControllerPlus> initController() {
    var controllerCompleter = Completer<WebViewControllerPlus>();

    webViewControllerPlus
      ..addJavaScriptChannel(
        onTapCallbackChannelLabel,
        onMessageReceived: (onTapCallbackMessage) =>
            onTapCallback?.call(onTapCallbackMessage.message),
      )
      ..addJavaScriptChannel(
        onTeXViewRenderedCallbackChannelLabel,
        onMessageReceived: (teXViewRenderedCallbackMessage) =>
            onTeXViewRenderedCallback
                ?.call(teXViewRenderedCallbackMessage.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _debugPrint("Page finished loading: $url");
            onPageFinishedCallback?.call(url);
            controllerCompleter.complete(webViewControllerPlus);
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith(
              baseUrl,
            )) {
              return NavigationDecision.navigate;
            } else {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..setOnConsoleMessage(
        (message) {
          _debugPrint('WebView Console: ${message.message}');
        },
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        baseUrl,
      ));

    if (!Platform.isMacOS) {
      // Setting a transparent background is not supported on macOS.
      webViewControllerPlus.setBackgroundColor(Colors.transparent);
    }

    return controllerCompleter.future;
  }

  /// Launches the given [url] in an external browser.
  static void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Prints a [message] to the console only in debug mode.
  static void _debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

/// A callback function type for handling messages from the rendering controller.
///
/// The [message] parameter contains the data sent from the JavaScript side.
typedef RenderingControllerCallback = void Function(dynamic message);
