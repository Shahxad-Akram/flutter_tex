import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewFontStyle {
  /// Custom font name registered as [TeXViewFont]
  final String fontFamily;

  /// Font size
  final int fontSize;

  /// Font size unit.
  final SizeUnit sizeUnit;

  TeXViewFontStyle({this.fontSize, this.fontFamily, this.sizeUnit});

  String initFontStyle() {
    return "${fontSize != null ? "font-size: " + getSizeWithUnit(fontSize, sizeUnit) + ";" : ""}${fontFamily != null ? "font-family: " + fontFamily + ";" : ""}";
  }
}
