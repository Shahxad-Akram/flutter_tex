import 'package:flutter/material.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewContainer extends TeXViewWidget {
  /// A [TeXViewWidget] as child.
  @required
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  const TeXViewContainer({this.child, this.style});

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div', type: 'tex-view-ink-well', node: Node.InternalChild)
            .toJson(),
        'data': this.child.toJson(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
