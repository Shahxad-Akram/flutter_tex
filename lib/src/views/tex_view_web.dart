// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:flutter_tex/src/utils/fake_ui.dart'
    if (dart.library.html) 'dart:ui' as ui;

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String? _lastData;
  double? _height;
  String _viewId = UniqueKey().toString();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return SizedBox(
      height: _height ?? 1,
      child: HtmlElementView(
        viewType: _viewId.toString(),
      ),
    );
  }

  @override
  void initState() {
    _height = widget.height;
    super.initState();
    js.context['TeXViewRenderedCallback'] = (message) {
      double height = double.parse(message.toString());
      if (this._height != height)
        setState(() {
          this._height = height;
        });
      widget.onRenderFinished?.call(height);
    };

    js.context['OnTapCallback'] = (id) {
      widget.child.onTapManager(id);
    };
  }

  void _initTeXView() {
    if (getRawData(widget) != _lastData) {
      ui.platformViewRegistry.registerViewFactory(
          _viewId.toString(),
          (int id) => IFrameElement()
            ..width = MediaQuery.of(context).size.width.toString()
            ..height = MediaQuery.of(context).size.height.toString()
            ..src =
                "assets/packages/flutter_tex/js/${widget.renderingEngine?.name ?? "katex"}/index.html"
            ..id = _viewId
            ..style.border = 'none');
      js.context.callMethod('initWebTeXView', [_viewId, getRawData(widget)]);
      this._lastData = getRawData(widget);
    }
  }
}
