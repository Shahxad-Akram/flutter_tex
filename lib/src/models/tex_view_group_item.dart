import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';

class TeXViewGroupItem extends TeXViewWidget {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  final String id;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  final bool rippleEffect;

  const TeXViewGroupItem(
      {@required this.id, @required this.child, this.rippleEffect});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        tag: 'div', type: 'tex-view-group-item', node: Node.InternalChild);
  }

  @override
  void onTapManager(String id) {}

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'id': this.id,
        'rippleEffect': this.rippleEffect ?? true,
        'data': this.child.toJson(),
      };
}
