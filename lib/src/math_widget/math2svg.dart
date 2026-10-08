import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_queue.dart';

/// A Flutter widget that renders TeX/LaTeX expressions as SVG images.
///
/// This widget uses the [TeXRenderingServer] to convert the input [math] string
/// into an SVG, which is then rendered using [SvgPicture].
///
/// It handles caching, loading states, error reporting, and automatic updates
/// when the input math changes.
class Math2SVG extends StatefulWidget {
  /// The TeX/LaTeX expression to render.
  final String math;

  /// The input type of the math expression (e.g., TeX, MathML).
  ///
  /// Defaults to [MathInputType.teX].
  final MathInputType teXInputType;

  /// A builder for the widget to display while the SVG is being generated.
  final WidgetBuilder? loadingWidgetBuilder;

  /// A builder for the widget to display when the SVG has been successfully generated.
  ///
  /// [svg] contains the raw SVG string.
  final Widget Function(BuildContext context, String svg)? formulaWidgetBuilder;

  /// A builder for the widget to display if an error occurs during rendering.
  final Widget Function(BuildContext context, Object? error)?
      errorWidgetBuilder;

  /// Whether to keep the state of this widget alive (e.g., in a ListView).
  ///
  /// Defaults to `false`.
  final bool wantKeepAlive;

  /// Creates a [Math2SVG] widget.
  const Math2SVG({
    super.key,
    required this.math,
    this.wantKeepAlive = false,
    this.teXInputType = MathInputType.teX,
    this.loadingWidgetBuilder,
    this.formulaWidgetBuilder,
    this.errorWidgetBuilder,
  });

  @override
  State<Math2SVG> createState() => _Math2SVGState();
}

class _Math2SVGState extends State<Math2SVG>
    with AutomaticKeepAliveClientMixin<Math2SVG> {
  String? _svgData;
  Object? _error;
  bool _isRendering = false;
  TexRenderingRequest? _currentRequest;

  @override
  void initState() {
    super.initState();
    _svgData =
        TeXRenderingServer.getCachedSVG(widget.math, widget.teXInputType);
    if (_svgData == null) {
      _resolveMath();
    }
  }

  @override
  void didUpdateWidget(Math2SVG oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.math != oldWidget.math ||
        widget.teXInputType != oldWidget.teXInputType) {
      _currentRequest?.cancel();

      final cached =
          TeXRenderingServer.getCachedSVG(widget.math, widget.teXInputType);
      if (cached != null) {
        setState(() {
          _svgData = cached;
          _isRendering = false;
        });
      } else {
        _resolveMath();
      }
    }
  }

  @override
  void dispose() {
    _currentRequest?.cancel();
    super.dispose();
  }

  Future<void> _resolveMath() async {
    if (!mounted) return;

    setState(() {
      _isRendering = true;
      _error = null;
    });

    try {
      _currentRequest = TeXRenderingServer.math2SVG(
        math: widget.math,
        mathInputType: widget.teXInputType,
      );

      final result = await _currentRequest!.future;

      if (mounted) {
        setState(() {
          _svgData = result;
          _isRendering = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // Discard errors caused by intentional cancellation.
        if (e.toString().contains("Cancelled")) {
          return;
        }
        setState(() {
          _error = e;
          _isRendering = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_error != null && _svgData == null) {
      return widget.errorWidgetBuilder?.call(context, _error) ??
          _buildDefaultError();
    }

    if (_svgData != null) {
      // RepaintBoundary isolates SVG rasterization from ancestor repaints.
      return RepaintBoundary(
        child: AnimatedOpacity(
          opacity: _isRendering ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: widget.formulaWidgetBuilder?.call(context, _svgData!) ??
              SvgPicture.string(
                _svgData!,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                placeholderBuilder: (_) => Text(widget.math),
              ),
        ),
      );
    }

    // Placeholder displayed prior to initial SVG resolution.
    return widget.loadingWidgetBuilder?.call(context) ??
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.math, style: const TextStyle(color: Colors.grey)),
        ));
  }

  Widget _buildDefaultError() {
    return Text('Error: $_error',
        style: const TextStyle(color: Colors.red, fontSize: 12));
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
