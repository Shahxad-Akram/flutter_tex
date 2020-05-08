import 'package:flutter/material.dart';
import 'package:flutter_tex/src/models/tex_view_tex.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewContainer {
  /// A random ID as an identifier to listen Callback in [onTap] in [TeXView]  when tap on TeXViewChild. If ID is null it won't trigger Callback event.
  final String id;

  /// A list of [TeXViewTeX].
  @required
  final List<TeXViewTeX> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  TeXViewContainer({this.id, this.children, this.style});

  Map<dynamic, dynamic> toJson() => {
        'id': this.id,
        'children': this.children?.map((child) => child?.toJson())?.toList(),
        'style': this.style?.initStyle(),
      };
}
