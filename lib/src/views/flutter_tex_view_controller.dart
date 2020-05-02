import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/utils/enums.dart';
import 'package:flutter_tex/src/utils/tex_view_child.dart';
import 'package:flutter_tex/src/views/mobile_tex_view.dart'
    if (dart.library.html) 'package:flutter_tex/src/views/web_tex_view.dart'
    as teXView;

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
///
///
class TeXView extends StatelessWidget {
  final Key key;

  @required
  final List<TeXViewChild> children;

  /// Style TeXView Widget with CSS code.
  final String style;

  /// Render Engine to render TeX.
  final RenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// On Tap Callback. It's not implemented for Flutter Web.
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
      this.onTap,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine});

  @override
  Widget build(BuildContext context) {
    return teXView.TeXView(
        height: this.height,
        loadingWidget: this.loadingWidget,
        keepAlive: this.keepAlive,
        key: this.key,
        onTap: this.onTap,
        onPageFinished: this.onPageFinished,
        onRenderFinished: this.onRenderFinished,
        children: this.children,
        style: this.style,
        renderingEngine: this.renderingEngine);
  }
}
