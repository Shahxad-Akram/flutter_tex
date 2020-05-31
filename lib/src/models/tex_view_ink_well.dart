import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/tex_view_style.dart';

class TeXViewInkWell extends TeXViewWidget {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  final String id;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  final bool rippleEffect;

  /// On Tap Callback when a tap is triggered.
  final Function(String id) onTap;

  const TeXViewInkWell(
      {@required this.child,
      @required this.id,
      this.onTap,
      this.rippleEffect,
      this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        tag: 'div', type: 'tex-view-ink-well', node: Node.InternalChild);
  }

  @override
  void onTapManager(String id) {
    if (this.id == id) this.onTap(id);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'id': this.id,
        'rippleEffect': this.rippleEffect ?? true,
        'data': this.child.toJson(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
