import 'package:flutter_tex/src/utils/tex_view_decoration.dart';

class TeXViewChild {
  /// A random ID as an identifier to listen Callback when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  String id;

  /// Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  String title;

  /// Raw String containing HTML and TEX Code e.g. String textHTML = r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  String body;

  /// Styling for TeXViewChild Widget , title and body.
  TeXViewDecoration teXViewDecoration;

  TeXViewChild({this.id, this.title, this.body, this.teXViewDecoration});

  Map<dynamic, dynamic> toJson() => {
        'id': id != null ? id.replaceAll("%", "%25") : null,
        'title': title != null ? title.replaceAll("%", "%25") : null,
        'body': body != null ? body.replaceAll("%", "%25") : null,
        'teXViewDecoration': teXViewDecoration != null ? teXViewDecoration.toJson() : ""
      };
}
