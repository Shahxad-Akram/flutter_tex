import 'package:flutter/material.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewTeX {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  final String id;

  /// Raw String containing HTML and TEX Code e.g. r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  @required
  final String data;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  TeXViewTeX(this.data, {this.id, this.style});

  Map<dynamic, dynamic> toJson() => {
        'id': this.id,
        'data': this.data,
        'style': this.style?.initStyle() ?? "",
      };
}
