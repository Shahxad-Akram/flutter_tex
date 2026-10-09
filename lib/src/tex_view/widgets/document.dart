import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that renders a document containing HTML and TeX content.
///
/// This widget is the primary way to display mixed text and math content.
/// It takes a raw string which can contain HTML tags (like `<br>`, `<b>`, etc.)
/// and TeX code (like `$$...$$` or `\(...\)`).
class TeXViewDocument extends TeXViewWidget {
  /// The raw string containing HTML and TeX code.
  ///
  /// Example: `r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """`
  final String data;

  /// The style to apply to the document.
  final TeXViewStyle? style;

  /// Creates a [TeXViewDocument] with the content [data] and optional [style].
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewDocument &&
        other.data == data &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(data, style);
}
