import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';

abstract class TeXViewWidget {
  const TeXViewWidget();

  TeXViewWidgetMeta meta();

  void onTapManager(String id);

  Map<dynamic, dynamic> toJson();
}