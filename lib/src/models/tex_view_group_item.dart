import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';

class TeXViewGroupItem extends TeXViewWidget {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  @required
  final String id;

  /// A [TeXViewWidget] as child.
  @required
  final TeXViewWidget child;

  final bool rippleEffect;

  const TeXViewGroupItem({this.id, this.child, this.rippleEffect});

  @override
  void onTapManager(String id) {}

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div',
                type: 'tex-view-group-item',
                node: Node.InternalChild)
            .toJson(),
        'id': this.id,
        'rippleEffect': this.rippleEffect ?? true,
        'data': this.child.toJson(),
      };
}
