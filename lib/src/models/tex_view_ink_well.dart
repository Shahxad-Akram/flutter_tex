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

  final bool rippleEffect;

  /// On Tap Callback when a tap is triggered.
  final Function(String id) onTap;

  const TeXViewInkWell(
      {this.child, this.id, this.onTap, this.rippleEffect, this.style});

  @override
  void onTapManager(String id) {
    if (this.id == id) this.onTap(id);
  }

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div', type: 'tex-view-ink-well', node: Node.InternalChild)
            .toJson(),
        'id': this.id,
        'rippleEffect': this.rippleEffect ?? true,
        'data': this.child.toJson(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
