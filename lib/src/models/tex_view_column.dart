import 'package:flutter/material.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewColumn extends TeXViewWidget {
  /// A list of [TeXViewWidget].
  @required
  final List<TeXViewWidget> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  const TeXViewColumn({this.children, this.style});

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div',
                type: 'tex-view-column',
                node: Node.InternalChildren)
            .toJson(),
        'data': this.children?.map((child) => child?.toJson())?.toList(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
