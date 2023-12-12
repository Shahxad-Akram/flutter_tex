import 'package:flutter_tex_plus/src/models/widget_meta.dart';

abstract class TeXViewWidget {
  const TeXViewWidget();

  TeXViewWidgetMeta meta();

  void onTapCallback(String id) {}

  Map<dynamic, dynamic> toJson();
}
