import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/manifests/widgets_manifest.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/style_utils.dart';

class TeXViewColumn extends TeXViewWidget {
  final String id;

  /// A list of [TeXViewWidget].

  final List<TeXViewWidget> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  const TeXViewColumn({this.id, @required this.children, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: this.id,
        tag: 'div',
        classList: 'tex-view-column',
        node: Node.InternalChildren);
  }

  @override
  void onTapManager(String id) {
    for (TeXViewWidget child in this.children) child.onTapManager(id);
  }

  @override
  Map toJson() =>
      {
        'meta': meta().toJson(),
        'data': this.children?.map((child) => child?.toJson())?.toList(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
