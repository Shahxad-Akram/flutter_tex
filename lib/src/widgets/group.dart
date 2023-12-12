import 'dart:convert';

import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewGroup extends TeXViewWidget {
  /// A list of [TeXViewWidget].
  final List<TeXViewGroupItem> children;

  /// On Tap Callback when a child is tapped.
  final Function(String id)? onTap;

  /// On Tap Callback when a child is tapped.
  final Function(List<String> ids)? onItemsSelection;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? selectedItemStyle;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? normalItemStyle;

  final bool single;

  const TeXViewGroup(
      {required this.children,
      required this.onTap,
      this.style,
      this.selectedItemStyle,
      this.normalItemStyle})
      : onItemsSelection = null,
        single = true;

  const TeXViewGroup.multipleSelection(
      {required this.children,
      required this.onItemsSelection,
      this.style,
      this.selectedItemStyle,
      this.normalItemStyle})
      : onTap = null,
        single = false;

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-group', node: Node.internalChildren);
  }

  @override
  void onTapCallback(String id) {
    if (single) {
      for (TeXViewGroupItem child in children) {
        if (child.id == id) onTap!(id);
      }
    } else {
      onItemsSelection!((jsonDecode(id) as List<dynamic>).cast<String>());
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': children.map((child) => child.toJson()).toList(),
        'single': single,
        'style': style?.initStyle() ?? teXViewDefaultStyle,
        'selectedItemStyle':
            selectedItemStyle?.initStyle() ?? teXViewDefaultStyle,
        'normalItemStyle': normalItemStyle?.initStyle() ?? teXViewDefaultStyle,
      };
}
