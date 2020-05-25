import 'package:flutter/material.dart';
import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewDocument extends TeXViewWidget {
  /// Raw String containing HTML and TEX Code e.g. r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String data;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  const TeXViewDocument(this.data, {this.style});

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(
                tag: 'div', type: 'tex-view-document', node: Node.Leaf)
            .toJson(),
        'data': this.data,
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
