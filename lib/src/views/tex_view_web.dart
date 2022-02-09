// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/fake_ui.dart'
    if (dart.library.html) 'dart:ui' as ui;

class TeXViewState extends State<TeXView> {
  String? _lastData;
  double widgetHeight = minHeight;
  final String _viewId = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
    _initTeXView();

    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return SizedBox(
        height: widgetHeight,
        width: constraints.maxWidth,
        child: AbsorbPointer(
          child: RepaintBoundary(
            child: HtmlElementView(
              key: widget.key ?? ValueKey(_viewId),
              viewType: _viewId,
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    js.context['TeXViewRenderedCallback'] = (message) {
      double viewHeight = double.parse(message.toString());
      if (viewHeight != widgetHeight) {
        setState(() {
          widgetHeight = viewHeight;
        });
      }
    };

    js.context['OnTapCallback'] = (id) {
      widget.child.onTapManager(id);
    };

    super.initState();
  }

  void _initTeXView() {
    if (getRawData(widget) != _lastData) {
      ui.platformViewRegistry.registerViewFactory(
          _viewId,
          (int id) => html.IFrameElement()
            ..src =
                "assets/packages/flutter_tex/js/${widget.renderingEngine?.name ?? "katex"}/index.html"
            ..id = _viewId
            ..style.border = '0');
      js.context.callMethod('initWebTeXView', [_viewId, getRawData(widget)]);
      _lastData = getRawData(widget);
    }
  }
}
