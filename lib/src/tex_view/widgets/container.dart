import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that contains a single child [TeXViewWidget] with styling options.
///
/// [TeXViewContainer] is useful for wrapping a widget to apply specific styles
/// (like padding, margins, borders, or background colors) to it.
class TeXViewContainer implements TeXViewWidget {
  /// The [TeXViewWidget] child to be wrapped by this container.
  final TeXViewWidget child;

  /// The style to apply to the container.
  ///
  /// Use [TeXViewStyle] to define properties such as height, width, padding,
  /// margin, and decoration.
  final TeXViewStyle? style;

  /// Creates a [TeXViewContainer] with a required [child] and optional [style].
  const TeXViewContainer({required this.child, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-container', node: Node.internalChild);
  }

  @override
  void onTapCallback(String id) {
    child.onTapCallback(id);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': child.toJson(),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewContainer &&
        other.child == child &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(child, style);
}
