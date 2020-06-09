import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/style/style_utils.dart';

class TeXViewFontStyle {
  /// Custom font name registered as [TeXViewFont]
  final String fontFamily;

  /// Font size
  final int fontSize;

  final String fontWeight;

  /// Font size unit.
  final TeXViewSizeUnit sizeUnit;

  TeXViewFontStyle({this.fontSize, this.fontWeight, this.fontFamily, this.sizeUnit});

  String initFontStyle() {
    return "${fontSize != null ? "font-size: " + getSizeWithUnit(fontSize, sizeUnit) + ";" : ""}${fontWeight != null ? "font-weight: " + fontWeight + ";" : ""}${fontFamily != null ? "font-family: " + fontFamily + ";" : ""}";
  }
}
