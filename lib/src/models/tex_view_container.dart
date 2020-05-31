import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/tex_view_style.dart';

class TeXViewContainer extends TeXViewWidget {
  /// A [TeXViewWidget] as child.
  final TeXViewWidget child;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  const TeXViewContainer({@required this.child, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        tag: 'div', type: 'tex-view-container', node: Node.InternalChild);
  }

  @override
  void onTapManager(String id) {
    this.child.onTapManager(id);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': this.child.toJson(),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
