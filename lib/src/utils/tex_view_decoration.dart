import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewDecoration {
  /// Styling for TeXViewChild Widget. Either you can user TeXViewStyles class or use your custom CSS code in a raw string.
  TeXViewStyle childStyle;

  /// Styling for TeXViewChild title. Either you can user TeXViewStyles class or use your custom CSS code in a raw string.
  TeXViewStyle titleStyle;

  /// Styling for TeXViewChild body. Either you can user TeXViewStyles class or use your custom CSS code in a raw string.
  TeXViewStyle bodyStyle;

  TeXViewDecoration({this.childStyle, this.titleStyle, this.bodyStyle});

  Map<dynamic, dynamic> toJson() => {
        'childStyle': childStyle != null
            ? childStyle.initStyle().replaceAll("%", "%25")
            : null,
        'titleStyle': titleStyle != null
            ? titleStyle.initStyle().replaceAll("%", "%25")
            : null,
        'bodyStyle': bodyStyle != null
            ? bodyStyle.initStyle().replaceAll("%", "%25")
            : null,
      };
}
