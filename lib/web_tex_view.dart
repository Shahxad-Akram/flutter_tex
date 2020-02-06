import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:universal_html/prefer_sdk/html.dart' as html;

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
///
///
class TeXView extends StatefulWidget {
  final Key key;

  ///Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String teXHTML;

  /// Fixed Height for TeXView.
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

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
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished});

  @override
  _TeXViewState createState() => _TeXViewState();
}

class _TeXViewState extends State<TeXView> {
  String teXViewId = 'tex_view';

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        teXViewId,
        (int viewId) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString() //'800'
          ..height = MediaQuery.of(context).size.height.toString() //'400'
          ..src =
              "packages/flutter_tex/MathJax/index.html?teXHTML=${Uri.encodeComponent(widget.teXHTML)}"
          ..style.border = 'none');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 300,
      child: HtmlElementView(
        viewType: teXViewId,
      ),
    );
  }
}
