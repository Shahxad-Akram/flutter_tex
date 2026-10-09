import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/globals.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_mobile.dart';
import 'package:flutter_tex/src/tex_view/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart'
    show WebViewWidget;

/// The Mobile (Android/iOS) implementation state for [TeXView].
///
/// This class orchestrates the interaction between the Flutter UI and a local [WebView].
/// It is responsible for:
/// 1.  Managing the [WebViewWidget] and its controller.
/// 2.  Bridging rendering requests (converting Dart objects to JSON and sending to JS).
/// 3.  Hearing back from JS (height updates, tap events).
/// 4.  Optimizing rendering performance via caching and async dispatching.
class TeXViewState extends State<TeXView>
    with AutomaticKeepAliveClientMixin<TeXView> {
  /// Broadcasts the calculated content height from the JS engine to the Flutter UI.
  final StreamController<double> heightStreamController = StreamController();

  /// The rendering controller instance. Can be shared (if `multiTeXView` is false)
  /// or unique per instance.
  late final TeXRenderingController teXRenderingController;

  /// Indicates whether the internal WebView controller has been initialized.
  bool _isReady = false;

  /// Cached JSON representation of the last rendered payload to avoid redundant bridge calls.
  String _oldRawData = "";

  @override
  void initState() {
    super.initState();

    if (TeXRenderingServer.multiTeXView) {
      teXRenderingController = TeXRenderingController();
      teXRenderingController.initController();
      teXRenderingController.onPageFinishedCallback =
          (_) => _onControllerReady();
    } else {
      teXRenderingController = TeXRenderingServer.teXRenderingController;
      _onControllerReady();
    }

    teXRenderingController.onTapCallback =
        (tapCallbackMessage) => widget.child.onTapCallback(tapCallbackMessage);

    teXRenderingController.onTeXViewRenderedCallback = (h) {
      double height = double.parse(h.toString()) + widget.heightOffset;
      if (mounted) {
        heightStreamController.add(height);
        widget.onRenderFinished?.call(height);
      }
    };
  }

  @override
  void didUpdateWidget(TeXView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child || widget.style != oldWidget.style) {
      _renderTeXView();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<double>(
        stream: heightStreamController.stream,
        builder: (context, snap) {
          if (snap.hasData && !snap.hasError) {
            return SizedBox(
              height: snap.data ?? initialHeight,
              child: WebViewWidget(
                controller: teXRenderingController.webViewControllerPlus,
              ),
            );
          }
          return widget.loadingWidgetBuilder?.call(context) ??
              const SizedBox.shrink();
        });
  }

  /// Marks the controller as ready and triggers the initial render.
  void _onControllerReady() {
    if (mounted) {
      setState(() {
        _isReady = true;
      });
      _renderTeXView();
    }
  }

  /// Serializes and dispatches the TeXView payload to the WebView.
  ///
  /// Defers execution to a microtask to avoid executing during the widget build phase.
  Future<void> _renderTeXView() async {
    if (!_isReady) return;
    await Future.microtask(() async {
      if (!mounted) return;

      final currentRawData = await getRawDataAsync(widget);
      if (!mounted) return;

      if (currentRawData != _oldRawData) {
        _oldRawData = currentRawData;
        await teXRenderingController.webViewControllerPlus.runJavaScript(
            '$initTeXViewChannelLabel(window, $currentRawData, false, "");');
      }
    });
  }

  @override
  void dispose() {
    // Release resources. Note: We don't dispose the controller if it's the shared singleton.
    heightStreamController.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
