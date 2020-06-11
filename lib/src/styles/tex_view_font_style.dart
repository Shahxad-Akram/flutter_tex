import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewFontStyle {
  /// Custom font name registered as [TeXViewFont]
  final String fontFamily;

  /// Font size
  final int fontSize;

  /// Font weight
  final TeXViewFontWeight fontWeight;

  /// Font size unit.
  final TeXViewSizeUnit sizeUnit;

  TeXViewFontStyle(
      {this.fontSize, this.fontFamily, this.sizeUnit, this.fontWeight});

  String initFontStyle() {
    return "${fontSize != null ? "font-size: " + getSizeWithUnit(fontSize, sizeUnit) + ";" : ""}${fontFamily != null ? "font-family: " + fontFamily + ";" : ""}${fontWeight != null ? "font-weight: " + _getFontWeightValue(fontWeight) + ";" : ""}";
  }

  static String _getFontWeightValue(TeXViewFontWeight teXViewFontWeight) {
    switch (teXViewFontWeight) {
      case TeXViewFontWeight.normal:
        return "normal";
        break;
      case TeXViewFontWeight.bold:
        return "bold";
        break;
      case TeXViewFontWeight.bolder:
        return "bolder";
        break;
      case TeXViewFontWeight.lighter:
        return "lighter";
        break;
      case TeXViewFontWeight.w100:
        return "100";
        break;
      case TeXViewFontWeight.w200:
        return "200";
        break;
      case TeXViewFontWeight.w300:
        return "300";
        break;
      case TeXViewFontWeight.w400:
        return "400";
        break;
      case TeXViewFontWeight.w500:
        return "500";
        break;
      case TeXViewFontWeight.w600:
        return "600";
        break;
      case TeXViewFontWeight.w700:
        return "700";
        break;
      case TeXViewFontWeight.w800:
        return "800";
        break;
      case TeXViewFontWeight.w900:
        return "900";
        break;
      case TeXViewFontWeight.initial:
        return "initial";
        break;
      case TeXViewFontWeight.inherit:
        return "inherit";
        break;
      default:
        return "normal";
    }
  }
}

enum TeXViewFontWeight {
  normal,
  bold,
  bolder,
  lighter,
  w100,
  w200,
  w300,
  w400,
  w500,
  w600,
  w700,
  w800,
  w900,
  initial,
  inherit
}
