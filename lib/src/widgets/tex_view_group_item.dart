import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/manifests/widgets_manifest.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';

class TeXViewGroupItem extends TeXViewWidget {
  final String id;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  final bool rippleEffect;

  const TeXViewGroupItem(
      {@required this.id, @required this.child, this.rippleEffect});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: this.id,
        tag: 'div',
        classList: 'tex-view-group-item',
        node: Node.InternalChild);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'rippleEffect': this.rippleEffect ?? true,
        'data': this.child.toJson(),
      };
}
