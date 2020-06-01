import 'dart:convert';

import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/style_utils.dart';

class CoreUtils {
  static String getRawData(widget) {
    return jsonEncode({
      'meta': TeXViewWidgetMeta(tag: 'div', type: 'tex-view', node: Node.Root)
          .toJson(),
      'id': null,
      'configurations': widget.renderingEngine?.getConfigurations(),
      'fonts': widget.fonts.map((font) => font.toJson()).toList(),
      'data': widget.child.toJson(),
      'style': widget.style?.initStyle() ?? teXViewDefaultStyle
    });
  }
}
