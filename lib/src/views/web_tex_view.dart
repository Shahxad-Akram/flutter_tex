// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/tex_view_rendering_engine.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  final Key key;

  /// A list of TeXViewChild.
  @required
  final List<TeXViewContainer> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  /// Render Engine to render TeX.
  final TeXViewRenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// Show or hide loadingWidget.
  final bool showLoadingWidget;

  /// On Tap Callback when a TeXViewChild is tapped.
  final Function(String childID) onTap;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  TeXView(
      {this.key,
      this.children,
      this.style,
      this.height,
      this.loadingWidget,
      this.showLoadingWidget = false,
      this.onTap,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine})
      : super(key: key);

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String lastTeXHTML;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();

    UniqueKey teXViewId = UniqueKey();

    if (getJsonRawTeXHTML() != lastTeXHTML) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
          teXViewId.toString(),
          (int viewId) => IFrameElement()
            ..width = MediaQuery.of(context).size.width.toString()
            ..height = MediaQuery.of(context).size.height.toString()
            ..src = _getTeXViewUrl()
            ..style.border = 'none');
      this.lastTeXHTML = getJsonRawTeXHTML();
    }

    return SizedBox(
      height: widget.height ?? 300,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: HtmlElementView(
            viewType: teXViewId.toString(),
          )),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                  ))),
        ],
      ),
    );
  }

  String getJsonRawTeXHTML() {
    return jsonEncode({
      "children": widget.children.map((child) => child.toJson()).toList(),
      "style": widget.style?.initStyle()
    });
  }

  String _getTeXViewUrl() {
    String baseUri = Uri.base.toString();
    String currentUrl = "";
    if (!baseUri.contains('http://localhost:')) {
      currentUrl =
          "${baseUri.replaceFirst("/#/", "").replaceFirst("#", "")}/assets/";
    }
    return "${currentUrl}packages/flutter_tex/src/flutter_tex_libs/${widget.renderingEngine.getEngineName()}/index.html?rawTeXHTML=${Uri.encodeComponent(getJsonRawTeXHTML())}";
  }

  void _teXViewItemTapCallbackHandler() {
    if (widget.onTap != null) {
      widget.onTap("not implemented");
    }
  }
}
