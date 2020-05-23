import 'dart:convert';

import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class CoreUtils {
  static String getJsonRawTeXHTML(
      List<TeXViewWidget> children, TeXViewStyle style) {
    return jsonEncode({
      'meta': TeXViewWidgetMeta(tag: 'div', type: 'tex-view', node: Node.Root)
          .toJson(),
      'id': null,
      'data': children.map((child) => child.toJson()).toList(),
      'style': style?.initStyle() ?? teXViewDefaultStyle
    });
  }
}
