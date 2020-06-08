import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/manifests/widgets_manifest.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/style_utils.dart';

class TeXViewGroup extends TeXViewWidget {
  final String id;

  /// A list of [TeXViewWidget].
  final List<TeXViewGroupItem> children;

  /// On Tap Callback when a child is tapped.
  final Function(String id) onTap;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle selectedItemStyle;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle normalItemStyle;

  const TeXViewGroup(
      {this.id,
      @required this.children,
      @required this.onTap,
      this.style,
      this.selectedItemStyle,
      this.normalItemStyle});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-group', node: Node.InternalChildren);
  }

  @override
  void onTapManager(String id) {
    for (TeXViewGroupItem child in this.children)
      if (child.id == id) this.onTap(id);
  }

  @override
  Map toJson() =>
      {
        'meta': meta().toJson(),
        'data': this.children?.map((child) => child?.toJson())?.toList(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
        'selectedItemStyle':
        this.selectedItemStyle?.initStyle() ?? teXViewDefaultStyle,
        'normalItemStyle':
        this.normalItemStyle?.initStyle() ?? teXViewDefaultStyle,
      };
}
