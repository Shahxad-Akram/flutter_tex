import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewColumn extends TeXViewWidget {
  final String? id;

  /// A list of [TeXViewWidget].
  final List<TeXViewWidget> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  const TeXViewColumn({this.id, required this.children, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: id,
        tag: 'div',
        classList: 'tex-view-column',
        node: Node.internalChildren);
  }

  @override
  void onTapManager(String id) {
    for (TeXViewWidget child in children) {
      child.onTapManager(id);
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': children.map((child) => child.toJson()).toList(),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
      };
}
