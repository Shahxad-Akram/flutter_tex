import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewDocument extends TeXViewWidget {
  /// Raw String containing HTML and TEX Code e.g. r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  final String data;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  const TeXViewDocument(this.data, {this.style});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-document', node: Node.leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': data,
        'style': style?.initStyle() ?? teXViewDefaultStyle,
      };
}
