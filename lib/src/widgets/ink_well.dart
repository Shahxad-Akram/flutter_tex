import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewInkWell implements TeXViewWidget {
  final String id;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  final bool? rippleEffect;

  /// On Tap Callback when a tap is triggered.
  final Function(String id)? onTap;

  const TeXViewInkWell(
      {required this.child,
      required this.id,
      this.onTap,
      this.rippleEffect,
      this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: id,
        tag: 'div',
        classList: 'tex-view-ink-well',
        node: Node.internalChild);
  }

  @override
  void onTapCallback(String id) {
    if (this.id == id) onTap!(id);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': child.toJson(),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
        'rippleEffect': rippleEffect ?? true,
      };
}
