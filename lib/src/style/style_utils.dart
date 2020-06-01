import 'dart:ui';

import 'package:flutter_tex/src/manifests/style_manifest.dart';

String teXViewDefaultStyle = "overflow: hidden; position: relative; ";

String getColor(Color color) {
  return "rgba(${color?.red}, ${color?.green}, ${color?.blue}, ${color?.alpha})";
}

String getElevation(int elevation, TeXViewSizeUnit sizeUnit) {
  return "0 ${elevation ?? 0 * 1}${UnitHelper.getValue(sizeUnit)} ${elevation ?? 0 * 2}${UnitHelper.getValue(sizeUnit)} 0 rgba(0,0,0,0.2)";
}

String getSizeWithUnit(int value, TeXViewSizeUnit sizeUnit) {
  return "${(value ?? 0).toString() + "${UnitHelper.getValue(sizeUnit)}"}";
}
