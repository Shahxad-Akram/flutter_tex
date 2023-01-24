import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/views/tex_view_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/views/tex_view_web.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXView extends StatefulWidget {
  /// A list of TeXViewChild.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  /// Register fonts.
  final List<TeXViewFont>? fonts;

  /// Render Engine to render TeX.
  final TeXViewRenderingEngine? renderingEngine;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  /// Callback when TEX rendering finishes.
  final Function(double height)? onRenderFinished;

  final Function()? onRenderStarted;

  /// Navigation Delegate, Works only in mobile
  final FutureOr<NavigationDecision> Function(NavigationRequest)?
      navigationDelegate;

  /// This disables any gestures on top of the [TeXView]. This allows other gestures to work like gestures for scrolling.
  final bool disableGesturesOnWeb;

  const TeXView({
    Key? key,
    required this.child,
    this.fonts,
    this.style,
    this.loadingWidgetBuilder,
    this.onRenderFinished,
    this.renderingEngine,
    this.navigationDelegate,
    this.onRenderStarted,
    this.disableGesturesOnWeb = true,
  }) : super(key: key);

  @override
  TeXViewState createState() => TeXViewState();
}
