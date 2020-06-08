import 'dart:convert';

import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/style_utils.dart';
import 'package:flutter_tex/src/views/tex_view.dart';

String getRawData(TeXView teXView) {
  return jsonEncode({
    'meta':
        TeXViewWidgetMeta(tag: 'div', classList: 'tex-view', node: Node.Root)
            .toJson(),
    'id': null,
    'fonts': (teXView.fonts ?? []).map((font) => font.toJson()).toList(),
    'data': teXView.child.toJson(),
    'style': teXView.style?.initStyle() ?? teXViewDefaultStyle
  });
}
