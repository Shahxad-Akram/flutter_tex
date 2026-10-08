import 'dart:async';
import 'dart:js_interop';
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:web/web.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_web.dart';
import 'package:flutter_tex/src/tex_view/tex_view.dart';
import 'package:flutter_tex/src/tex_view/utils/core_utils.dart';

/// The Web-specific implementation state for [TeXView].
///
/// This class utilizes an `iframe` element to host the TeX rendering engine.
/// It uses `dart:js_interop` to communicate seamlessly with the JavaScript context
/// running inside the iframe.
///
/// Advantages over standard WebView:
/// 1.  Leightweight `iframe` element.
/// 2.  Direct JS interop (faster than channel messages).
class TeXViewState extends State<TeXView>
    with AutomaticKeepAliveClientMixin<TeXView> {
  /// A global unique identifier for the iframe to differentiate between multiple views in the DOM.
  final String _iframeId = UniqueKey().toString();

  /// The standard HTML iframe element used as the container.
  late final HTMLIFrameElement iframeElement;

  /// Stream to pass the calculated height from JS to the Flutter UI layer.
  final StreamController<double> heightStreamController = StreamController();

  /// Reference to the iframe's internal window object for calling functions.
  late final Window _iframeContentWindow;

  /// Cached JSON representation of the last rendered payload to avoid redundant bridge calls.
  String _oldRawData = '';

  /// Web loading state flag.
  bool _isReady = false;

  @override
  void initState() {
    super.initState();

    iframeElement = HTMLIFrameElement()
      ..id = _iframeId
      ..src = "assets/packages/flutter_tex/core/flutter_tex.html"
      ..style.height = '100%'
      ..style.width = '100%'
      ..style.border = '0';

    TeXRenderingControllerWeb.registerInstance(_iframeId, this);

    iframeElement.onLoad.listen((_) {
      _iframeContentWindow = iframeElement.contentWindow!;
      _isReady = true;
      _renderTeXView();
    });

    platformViewRegistry.registerViewFactory(
        _iframeId, (int viewId) => iframeElement);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _renderTeXView();

    return StreamBuilder<double>(
        stream: heightStreamController.stream,
        builder: (context, snap) {
          return SizedBox(
            height: snap.hasData && !snap.hasError ? snap.data! : initialHeight,
            child: HtmlElementView(
              key: widget.key ?? ValueKey(_iframeId),
              viewType: _iframeId,
            ),
          );
        });
  }

  /// Handles tap events routed from JavaScript.
  void onTap(JSString tapId) => widget.child.onTapCallback(tapId.toDart);

  /// Handles height updates routed from JavaScript.
  void onTeXViewRendered(JSNumber h) {
    double height = h.toDartDouble + widget.heightOffset;

    if (mounted) {
      heightStreamController.add(height);
      widget.onRenderFinished?.call(height);
    }
  }

  /// Asynchronously updates the TeX content in the iframe.
  ///
  /// Defers execution to a microtask to avoid invoking interop during the build phase.
  Future<void> _renderTeXView() async {
    if (!_isReady) return;
    await Future.microtask(() async {
      if (!mounted) return;

      final currentRawData = await getRawDataAsync(widget);
      if (!mounted) return;

      if (currentRawData != _oldRawData) {
        _oldRawData = currentRawData;
        initTeXView(_iframeContentWindow, currentRawData, true, _iframeId);
      }
    });
  }

  @override
  void didUpdateWidget(TeXView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child || widget.style != oldWidget.style) {
      _renderTeXView();
    }
  }

  @override
  void dispose() {
    if (mounted) {
      heightStreamController.close();
    }
    // Critical cleanup: Remove reference from global controller to prevent memory leaks.
    TeXRenderingControllerWeb.unregisterInstance(_iframeId);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
