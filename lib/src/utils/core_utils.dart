import 'dart:convert';

import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';
import 'package:flutter_tex/src/views/tex_view.dart';

String getRawData(TeXView teXView) {
  return jsonEncode({
    'meta':
        TeXViewWidgetMeta(tag: 'div', classList: 'tex-view', node: Node.Root)
            .toJson(),
    'fonts': (teXView.fonts ?? []).map((font) => font.toJson()).toList(),
    'data': teXView.child.toJson(),
    'style': teXView.style?.initStyle() ?? teXViewDefaultStyle
  });
}
