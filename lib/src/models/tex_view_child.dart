import 'package:flutter_tex/src/models/tex_view_decoration.dart';

class TeXViewChild {
  /// A random ID as an identifier to listen Callback when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  String id;

  /// Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  String title;

  /// Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  String body;

  /// Styling for TeXViewChild Widget , title and body.
  TeXViewDecoration decoration;

  TeXViewChild({this.id, this.title, this.body, this.decoration});

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'decoration': decoration?.toJson()
      };
}
