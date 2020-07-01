import 'dart:html';
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String _lastData;
  double _height = 750;
  String viewId = UniqueKey().toString();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return Container(
      color: Colors.green,
      height: _height,
      child: HtmlElementView(
        viewType: viewId.toString(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    js.context['TeXViewRenderedCallback'] = (message) {
      double height = double.parse(message.toString());
      print("new-$height     old-$_height");
      //if (widget.height == null)
      //setState(() {
      _height = height;
      //});
    };
    js.context['OnTapCallback'] = (id) {
      widget.child.onTapManager(id);
    };
  }

  void _initTeXView() {
    if (getRawData(widget) != _lastData) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
          viewId.toString(),
          (int id) => IFrameElement()
            ..width = MediaQuery.of(context).size.width.toString()
            ..height = MediaQuery.of(context).size.height.toString()
            ..src =
                "assets/packages/flutter_tex/js/${widget.renderingEngine?.name ?? "katex"}/index.html"
            ..id = viewId
            ..style.border = 'none');
      js.context.callMethod('initWebTeXView', [viewId, getRawData(widget)]);
      this._lastData = getRawData(widget);
    }
  }
}
