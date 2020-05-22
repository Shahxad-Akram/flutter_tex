// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String lastTeXHTML;
  double _height = 300;

  String platformId;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _initTeXView();
    return SizedBox(
      height: 1118,
      child: HtmlElementView(
        viewType: platformId.toString(),
      ),
    );
  }

  String getJsonRawTeXHTML() {
    return jsonEncode({
      "children": widget.children.map((child) => child.toJson()).toList(),
      "style": widget.style?.initStyle()
    });
  }

  @override
  void initState() {
    js.context['renderedWebTeXViewHeight'] = (height) {
      setState(() {
        _height = double.parse(height.toString());
        print(_height.toString());
      });
    };
    super.initState();
  }

  String _getTeXViewUrl() {
    String baseUri = Uri.base.toString();
    String currentUrl = "";
    if (!baseUri.contains('http://localhost:')) {
      currentUrl =
          "${baseUri.replaceFirst("/#/", "").replaceFirst("#", "")}/assets/";
    }
    return "${currentUrl}packages/flutter_tex/src/flutter_tex_libs/${widget.renderingEngine.getEngineName()}/index.html?platformId=$platformId";
  }

  void _initTeXView() {
    if (getJsonRawTeXHTML() != lastTeXHTML) {
      platformId = DateTime.now().microsecondsSinceEpoch.toString();
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
          platformId.toString(),
          (int viewId) => html.IFrameElement()
            ..width = MediaQuery.of(context).size.width.toString()
            ..height = MediaQuery.of(context).size.height.toString()
            ..src = _getTeXViewUrl()
            ..id = 'tex_view_$platformId'
            ..style.border = 'none');
      js.context
          .callMethod('initWebTeXView', [platformId, getJsonRawTeXHTML()]);
      this.lastTeXHTML = getJsonRawTeXHTML();
    }
  }
}
