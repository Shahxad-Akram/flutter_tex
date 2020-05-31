import 'dart:convert';

import 'package:flutter_tex/src/models/tex_view_font.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/tex_view_style.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class CoreUtils {
  static String getRawData(
      TeXViewWidget child, TeXViewStyle style, List<TeXViewFont> fonts) {
    return jsonEncode({
      'meta': TeXViewWidgetMeta(tag: 'div', type: 'tex-view', node: Node.Root)
          .toJson(),
      'id': null,
      'fonts': fonts.map((font) => font.toJson()).toList(),
      'data': child.toJson(),
      'style': style?.initStyle() ?? teXViewDefaultStyle
    });
  }
}
