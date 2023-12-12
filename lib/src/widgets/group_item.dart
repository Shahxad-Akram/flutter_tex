import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';

class TeXViewGroupItem implements TeXViewWidget {
  final String id;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  final bool? rippleEffect;

  const TeXViewGroupItem(
      {required this.id, required this.child, this.rippleEffect});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: id,
        tag: 'div',
        classList: 'tex-view-group-item',
        node: Node.internalChild);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': child.toJson(),
        'rippleEffect': rippleEffect ?? true,
      };

  @override
  void onTapCallback(String id) {
    child.onTapCallback(id);
  }
}
