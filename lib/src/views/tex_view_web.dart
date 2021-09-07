// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/fake_ui.dart'
    if (dart.library.html) 'dart:ui' as ui;

class TeXViewState extends State<TeXView> {
  String? _lastData;
  double viewHeight = 1;
  String _viewId = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
    _initTeXView();

    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return SizedBox(
        height: viewHeight,
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
    print("viewid $_viewId");

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      /*  final _iframe = _iframeElementMap[widget.key];
      _iframe?.onLoad.listen((event) {});*/
    });

    js.context['TeXViewRenderedCallback'] = (message) {
      double rHeight = double.parse(message.toString());
      double dHeight = MediaQuery.of(context).size.height;
      // print(
      //     "key-$_viewId       new-$rHeight     old-$viewHeight     device-$dHeight");
      if (rHeight > dHeight / 1.8) {
        rHeight = dHeight / 1.8;
      }
      if (rHeight != viewHeight) {
        setState(() {
          viewHeight = rHeight;
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
      this._lastData = getRawData(widget);
    }
  }

  @override
  void didUpdateWidget(TeXView oldWidget) {
    if (mounted) setState(() {});

/*    if (oldWidget.height != widget.height) {
      if (mounted) setState(() {});
    }
    if (oldWidget.width != widget.width) {
      if (mounted) setState(() {});
    }
    if (oldWidget.src != widget.src) {
      if (mounted) setState(() {});
    }
    if (oldWidget.headers != widget.headers) {
      if (mounted) setState(() {});
    }*/
    super.didUpdateWidget(oldWidget);
  }
}
