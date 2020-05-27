import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';

class TeXViewGroupItem extends TeXViewInkWell {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  @required
  final String id;

  /// A [TeXViewWidget] as child.
  @required
  final TeXViewWidget child;

  const TeXViewGroupItem({this.id, this.child});

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div',
                type: 'tex-view-group-item',
                node: Node.InternalChild)
            .toJson(),
        'id': this.id,
        'data': this.child.toJson(),
      };
}
