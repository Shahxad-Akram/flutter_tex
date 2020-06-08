import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/manifests/models_manifest.dart';
import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/manifests/widgets_manifest.dart';
import 'package:flutter_tex/src/views/tex_view_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/views/tex_view_web.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  /// A list of TeXViewChild.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  /// Register fonts.
  final List<TeXViewFont> fonts;

  /// Render Engine to render TeX.
  final TeXViewRenderingEngine renderingEngine;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context) loadingWidgetBuilder;

  /// Callback when TEX rendering finishes.
  final Function(double height) onRenderFinished;

  /// Callback when TeXView loading finishes.
  final Function(TeXViewController controller) onTeXViewCreated;

  /// Keep widget Alive. (True by default).
  final bool keepAlive;

  const TeXView({
    Key key,
    @required this.child,
    this.fonts,
    this.style,
    this.loadingWidgetBuilder,
    this.keepAlive,
    this.onRenderFinished,
    this.onTeXViewCreated,
    this.renderingEngine,
  }) : super(key: key);

  @override
  TeXViewState createState() => TeXViewState();
}
