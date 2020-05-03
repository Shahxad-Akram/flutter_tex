import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewDecoration {
  /// Styling for TeXViewChild Widget. Either you can user TeXViewStyle() class or use TeXViewStyle.fromCSS().
  TeXViewStyle style;

  /// Styling for TeXViewChild title. Either you can user TeXViewStyle() class or use TeXViewStyle.fromCSS().
  TeXViewStyle titleStyle;

  /// Styling for TeXViewChild body. Either you can user TeXViewStyle() class or use TeXViewStyle.fromCSS().
  TeXViewStyle bodyStyle;

  TeXViewDecoration({this.style, this.titleStyle, this.bodyStyle});

  Map<dynamic, dynamic> toJson() => {
        'style': style?.initStyle() ?? "",
        'titleStyle': titleStyle?.initStyle() ?? "",
        'bodyStyle': bodyStyle?.initStyle() ?? "",
      };
}
