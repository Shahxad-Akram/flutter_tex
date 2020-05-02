import 'package:flutter/material.dart';
import 'package:flutter_tex/src/tex_view_style.dart';

class TeXViewChild {
  @required
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
