// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  final Key key;

  ///Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String teXHTML;

  /// Render Engine to render TeX.
  final RenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// On Tap Callback.
  final Function onTap;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  TeXView(
      {this.key,
      this.teXHTML,
      this.height,
      this.loadingWidget,
      this.onTap,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine});

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  String oldTeXHTML;

  @override
  bool get wantKeepAlive => widget.keepAlive ?? true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();

    UniqueKey teXViewId = UniqueKey();

    if (widget.teXHTML != oldTeXHTML) {
      String renderEngine = widget.renderingEngine == RenderingEngine.MathJax
          ? "mathjax"
          : "katex";
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
          teXViewId.toString(),
              (int viewId) =>
          IFrameElement()
            ..width = MediaQuery
                .of(context)
                .size
                .width
                .toString()
            ..height = MediaQuery
                .of(context)
                .size
                .height
                .toString()
            ..src =
                "packages/flutter_tex/src/tex_libs/$renderEngine/index.html?teXHTML=${Uri
                .encodeComponent(widget.teXHTML)}"
            ..style.border = 'none');
      this.oldTeXHTML = widget.teXHTML;
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
                    onTap: widget.onTap,
                  ))),
        ],
      ),
    );
  }
}
