
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewChild {
  /// A random ID as an identifier to listen Callback when tap on TeXViewChild.
  String id;

  String title;
  String body;
  TeXViewStyle style;

  TeXViewChild({this.id, this.title, this.body, this.style});

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'style': style != null ? style.toJson() : ""
      };
}
