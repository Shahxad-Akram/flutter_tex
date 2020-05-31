import 'dart:ui';

String teXViewDefaultStyle = "overflow: hidden; position: relative; ";

String getColor(Color color) {
  return "rgba(${color?.red}, ${color?.green}, ${color?.blue}, ${color?.alpha})";
}

String getElevation(int elevation, SizeUnit sizeUnit) {
  return "0 ${elevation ?? 0 * 1}${UnitHelper.getValue(sizeUnit)} ${elevation ?? 0 * 2}${UnitHelper.getValue(sizeUnit)} 0 rgba(0,0,0,0.2)";
}

String getSizeWithUnit(int value, SizeUnit sizeUnit) {
  return "${(value ?? 0).toString() + "${UnitHelper.getValue(sizeUnit)}"}";
}

enum SizeUnit { Pixels, Percent, Em, Pt }

enum TeXViewTextAlign { Center, Left, Right, Justify }

class TeXViewTextAlignHelper {
  static String getValue(TeXViewTextAlign teXViewTextAlign) {
    switch (teXViewTextAlign) {
      case TeXViewTextAlign.Center:
        return "center";
      case TeXViewTextAlign.Left:
        return "left";
      case TeXViewTextAlign.Right:
        return "right";
      case TeXViewTextAlign.Justify:
        return "justify";
      default:
        return "left";
    }
  }
}

class UnitHelper {
  static String getValue(SizeUnit unit) {
    switch (unit) {
      case SizeUnit.Pixels:
        return "px";
      case SizeUnit.Percent:
        return "%";
      case SizeUnit.Em:
        return "em";
      case SizeUnit.Pt:
        return "pt";
      default:
        return "px";
    }
  }
}
