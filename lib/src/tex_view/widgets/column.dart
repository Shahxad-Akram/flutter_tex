import 'package:flutter/foundation.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A [TeXViewWidget] that displays its children in a vertical linear array.
///
/// This widget behaves similarly to Flutter's [Column] widget but is rendered
/// as an HTML `div` with children stacked vertically.
class TeXViewColumn implements TeXViewWidget {
  /// The list of [TeXViewWidget]s to be displayed as children of this column.
  final List<TeXViewWidget> children;

  /// The style to apply to the column container.
  ///
  /// You can use [TeXViewStyle] to define properties like margin, padding,
  /// border, background color, etc.
  final TeXViewStyle? style;

  /// Creates a [TeXViewColumn] with a list of [children] and an optional [style].
  const TeXViewColumn({required this.children, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-column', node: Node.internalChildren);
  }

  @override
  void onTapCallback(String id) {
    for (TeXViewWidget child in children) {
      child.onTapCallback(id);
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': children.map((child) => child.toJson()).toList(),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewColumn &&
        other.style == style &&
        listEquals(children, other.children);
  }

  @override
  int get hashCode => Object.hash(style, Object.hashAll(children));
}
