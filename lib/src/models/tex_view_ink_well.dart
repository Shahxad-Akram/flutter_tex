import 'package:flutter/material.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewInkWell extends TeXViewWidget {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  @required
  final String id;

  /// A [TeXViewWidget] as child.
  @required
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  TeXViewInkWell({this.child, this.id, this.style});

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div', type: 'tex-view-ink-well', node: Node.InternalChild)
            .toJson(),
        'id': this.id,
        'data': this.child.toJson(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
