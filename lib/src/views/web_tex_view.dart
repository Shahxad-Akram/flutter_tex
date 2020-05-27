import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String _lastData;
  double _height = 250;
  String viewId = UniqueKey().toString();

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return Container(
      color: Colors.green,
      height: widget.height ?? _height,
      child: HtmlElementView(
        viewType: viewId.toString(),
      ),
    );
  }

  String getRawData() {
    return CoreUtils.getRawData(widget.children, widget?.style);
  }

  @override
  void initState() {
    super.initState();
    js.context['RenderedTeXViewHeight'] = (message) {
      double height = double.parse(message.toString());
      print("new-$height     old-$_height");
      //if (widget.height == null)
      //setState(() {
      _height = height;
      //});
    };
    js.context['OnTapCallback'] = (id) {
      if (widget.onTap != null) {
        widget.onTap(id);
      }
    };
  }

  void _initTeXView() {
    if (getRawData() != _lastData) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
          viewId.toString(),
          (int id) => html.IFrameElement()
            ..width = MediaQuery.of(context).size.width.toString()
            ..height = MediaQuery.of(context).size.height.toString()
            ..src =
                "assets/packages/flutter_tex/src/flutter_tex_libs/${widget.renderingEngine.getEngineName()}/index.html"
            ..id = viewId
            ..style.border = 'none');
      js.context.callMethod('initWebTeXView', [viewId, getRawData()]);
      this._lastData = getRawData();
    }
  }
}
