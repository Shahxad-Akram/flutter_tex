import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/globals.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_cache.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_queue.dart';
import 'package:flutter_tex/src/tex_view/tex_view_web.dart';
import 'package:web/web.dart';

/// The Web-specific implementation of [TeXRenderingServer].
///
/// Unlike the mobile implementation which spawns a WebView, this implementation
/// leverages `dart:js_interop` (Dart 3.3+) to communicate directly with the browser's
/// JavaScript context where MathJax is loaded.
///
/// Optimization Strategy:
/// - **Direct JS calls**: No IPC overhead like Mobile.
/// - **Async UI Unblocking**: Uses `Future.delayed(Duration.zero)` to yield control to the event loop,
///   ensure the UI remains responsive even during heavy rendering tasks.
/// - **Higher Concurrency**: Browsers can handle more concurrent renders than mobile WebViews.
class TeXRenderingServer {
  /// A flag to indicate if multiple TeXViews are being used.
  static bool multiTeXView = false;

  // Browser JS interop incurs negligible bridge overhead, allowing higher concurrency.
  static final TexRenderingQueue _queue =
      TexRenderingQueue(maxConcurrentRequests: 6);

  /// Starts the TeX rendering server for the web.
  ///
  /// Initializes the [TeXRenderingControllerWeb] to handle callbacks from JS.
  static Future<void> start({int port = 0}) async {
    TeXRenderingControllerWeb.initialize();
  }

  /// Synchronous cache check for the Widget.
  static String? getCachedSVG(String math, MathInputType type) {
    return TexRenderingCache.getCachedSVG(math, type);
  }

  /// Converts a TeX, MathML, or AsciiMath string into an SVG image.
  ///
  /// This wraps the raw JS call with our Caching and Queueing logic to ensure
  /// stability and performance.
  static TexRenderingRequest math2SVG(
      {required String math, required MathInputType mathInputType}) {
    return TexRenderingCache.render(
      math: math,
      mathInputType: mathInputType,
      onMissing: () {
        return _queue.addRequest(
            math: math,
            inputType: mathInputType,
            processor: () async {
              try {
                // Yield briefly to the event loop to keep frame rendering smooth.
                await Future.delayed(Duration.zero);
                return math2SVGflutterTeXLiteDOM(math, mathInputType.type);
              } catch (e) {
                if (kDebugMode) {
                  print('Error in math2SVG: $e');
                }
                throw 'Error rendering TeX: $e';
              }
            });
      },
    );
  }

  /// Stops the TeX rendering server for the web.
  ///
  /// This disposes of the [TeXRenderingControllerWeb], cleaning up the
  /// JavaScript callbacks.
  static Future<void> stop() async {
    TeXRenderingControllerWeb.dispose();
  }
}

/// A JavaScript interop binding for the `OnTeXViewRenderedCallback` function.
///
/// This allows Dart to set a JavaScript function that will be called when
/// the TeX view has finished rendering.
@JS(onTeXViewRenderedCallbackChannelLabel)
external set onTeXViewRenderedCallback(JSFunction callback);

/// A JavaScript interop binding for the `OnTapCallback` function.
///
/// This allows Dart to set a JavaScript function that will be called when
/// a tap event occurs within the rendered TeX content.
@JS(onTapCallbackChannelLabel)
external set onTapCallback(JSFunction callback);

/// A JavaScript interop binding for the `initTeXViewWeb` function.
///
/// This function is called from the Dart side to initialize a specific
/// TeX view instance within its iframe.
@JS(initTeXViewChannelLabel)
external void initTeXView(
    Window context, String flutterTeXData, bool isWeb, String iframeId);

/// A JavaScript interop binding for the `mathJaxLiteDOM.math2SVG` function.
///
/// This function performs the actual conversion of a math string to an SVG.
@JS(mathJaxFlutterTeXLiteDOMMath2SVGChannelLabel)
external String math2SVGflutterTeXLiteDOM(String math, String inputType);

/// Manages the global callbacks and communication between JavaScript and Dart for web.
///
/// This controller maintains a registry of active [TeXViewState] instances and
/// dispatches JavaScript events to the appropriate Dart instance.
class TeXRenderingControllerWeb {
  static bool _isInitialized = false;

  /// A map to hold references to the state of each TeXView instance, keyed by viewId.
  static final Map<String, TeXViewState> _instances = {};

  /// Registers an instance of [TeXViewState] to be managed by the controller.
  static void registerInstance(String viewId, TeXViewState instance) {
    _instances[viewId] = instance;
  }

  /// Unregisters a [TeXViewState] instance when it's disposed to prevent memory leaks.
  static void unregisterInstance(String viewId) {
    _instances.remove(viewId);
  }

  /// Initializes the controller by setting up the global JavaScript callbacks.
  ///
  /// This is idempotent and will only run once.
  static void initialize() {
    if (_isInitialized) return;

    onTeXViewRenderedCallback = _onTeXViewRendered.toJS;
    onTapCallback = _onTap.toJS;
    _isInitialized = true;
  }

  /// Disposes of the controller, cleaning up JavaScript callbacks and resetting state.
  static void dispose() {
    if (!_isInitialized) return;
    onTeXViewRenderedCallback = (() {}).toJS;
    onTapCallback = (() {}).toJS;
    _isInitialized = false;
  }

  /// The Dart callback that is triggered from the JavaScript `OnTeXViewRenderedCallback`.
  ///
  /// It finds the corresponding [TeXViewState] instance and calls its `onTeXViewRendered` method.
  static void _onTeXViewRendered(JSNumber h, JSString iframeId) {
    final instance = _instances[iframeId.toDart];
    if (instance != null && instance.mounted) {
      instance.onTeXViewRendered(h);
    }
  }

  /// The Dart callback that is triggered from the JavaScript `OnTapCallback`.
  ///
  /// It finds the corresponding [TeXViewState] instance and calls its `onTap` method.
  static void _onTap(JSString tapId, JSString iframeId) {
    final instance = _instances[iframeId.toDart];
    if (instance != null && instance.mounted) {
      instance.onTap(tapId);
    }
  }
}
