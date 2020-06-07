import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/manifests/models_manifest.dart';
import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/manifests/widgets_manifest.dart';
import 'package:flutter_tex/src/views/tex_view_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/views/tex_view_web.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  final Key key;

  /// A list of TeXViewChild.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  final List<TeXViewFont> fonts;

  /// Render Engine to render TeX.
  final TeXViewRenderingEngine renderingEngine;

  /// Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  final double height;

  /// Show a loading widget before rendering completes.
  final Widget loadingWidget;

  /// Show or hide loadingWidget.
  final bool showLoadingWidget;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(String message) onPageFinished;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  const TeXView(
      {this.key,
      @required this.child,
      this.fonts,
      this.style,
      this.height,
      this.loadingWidget,
      this.showLoadingWidget = false,
      this.keepAlive,
      this.onRenderFinished,
      this.onPageFinished,
      this.renderingEngine = const TeXViewRenderingEngine.katex()})
      : super(key: key);

  @override
  TeXViewState createState() => TeXViewState();
}
