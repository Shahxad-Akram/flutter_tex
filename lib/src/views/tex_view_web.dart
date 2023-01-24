// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/fake_ui.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:pointer_interceptor/pointer_interceptor.dart';

class TeXViewState extends State<TeXView> {
  String? _lastData;
  ValueNotifier<double> widgetHeight = ValueNotifier(minHeight);
  final String _viewId = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
    _initTeXView();
    return ValueListenableBuilder<double>(
      valueListenable: widgetHeight,
      builder: (context, height, _) {
        return Stack(
          children: [
            SizedBox(
              height: height,
              child: HtmlElementView(
                key: ValueKey(_viewId),
                viewType: _viewId,
              ),
            ),
            if (widget.disableGesturesOnWeb)
              PointerInterceptor(
                child: SizedBox(
                  height: height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _initWebview();
    super.initState();
  }

  void _initWebview() {
    ui.platformViewRegistry.registerViewFactory(
        _viewId,
        (int id) => html.IFrameElement()
          ..src =
              "assets/packages/flutter_tex/js/${widget.renderingEngine?.name ?? "katex"}/index.html"
          ..id = _viewId
          ..style.height = '100%'
          ..style.width = '100%'
          ..style.border = '0');
    js.context['TeXViewRenderedCallback_$_viewId'] = (message) {
      double viewHeight = double.parse(message.toString());
      if (viewHeight != widgetHeight.value) {
        widgetHeight.value = viewHeight;
      }
    };

    js.context['OnTapCallback'] = (id) {
      widget.child.onTapCallback(id);
    };
  }

  void _initTeXView() {
    if (getRawData(widget) != _lastData) {
      js.context.callMethod('initWebTeXView', [
        _viewId,
        getRawData(widget),
        widget.renderingEngine?.name ?? "katex"
      ]);
      _lastData = getRawData(widget);
    }
  }
}
