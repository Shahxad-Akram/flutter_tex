import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that responds to taps with a visual ripple effect.
///
/// This widget wraps a [child] widget and triggers the [onTap] callback when tapped.
class TeXViewInkWell implements TeXViewWidget {
  /// A unique identifier for this ink well.
  ///
  /// This ID is passed to the [onTap] callback to identify which widget was tapped.
  final String id;

  /// The child widget to be wrapped by the ink well.
  final TeXViewWidget child;

  /// The style to apply to the ink well container.
  final TeXViewStyle? style;

  /// Whether to show a ripple effect on tap. Defaults to `true`.
  final bool? rippleEffect;

  /// A callback function that is called when the widget is tapped.
  ///
  /// The callback receives the [id] of the widget.
  final Function(String id)? onTap;

  /// Creates a [TeXViewInkWell] widget.
  const TeXViewInkWell(
      {required this.child,
      required this.id,
      this.onTap,
      this.rippleEffect,
      this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: id,
        tag: 'div',
        classList: 'tex-view-ink-well',
        node: Node.internalChild);
  }

  @override
  void onTapCallback(String id) {
    if (this.id == id) {
      onTap?.call(id);
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': child.toJson(),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
        'rippleEffect': rippleEffect ?? true,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewInkWell &&
        other.id == id &&
        other.child == child &&
        other.style == style &&
        other.rippleEffect == rippleEffect;
  }

  @override
  int get hashCode => Object.hash(id, child, style, rippleEffect);
}
