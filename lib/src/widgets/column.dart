import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

/// A widget that displays its children in a vertical array.
class TeXViewColumn implements TeXViewWidget {
  /// A list of [TeXViewWidget].
  final List<TeXViewWidget> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

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
}
