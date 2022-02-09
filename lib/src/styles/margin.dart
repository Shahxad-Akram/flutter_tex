import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

///TeXViewMargin to manage different types of margin of TeXView.
class TeXViewMargin {
  final TeXViewSizeUnit? sizeUnit;

  /// Top margin.
  final int? top;

  /// Bottom margin.
  final int? bottom;

  /// Right margin.
  final int? right;

  /// Left margin.
  final int? left;

  /// All sides margin and it'll override top, bottom,right and left margins.
  final int? all;

  final String? zeroAuto;

  const TeXViewMargin.all(this.all, {this.sizeUnit})
      : zeroAuto = null,
        top = null,
        bottom = null,
        right = null,
        left = null;

  const TeXViewMargin.only(
      {this.sizeUnit, this.top, this.bottom, this.right, this.left})
      : all = null,
        zeroAuto = null;

  const TeXViewMargin.zeroAuto()
      : zeroAuto = "0 auto",
        sizeUnit = null,
        all = null,
        top = null,
        bottom = null,
        right = null,
        left = null;

  /// It'll provide CSS margin code.
  String getMargin() {
    if (all != null) {
      return "margin:${getSizeWithUnit(all, sizeUnit)};";
    } else if (zeroAuto != null) {
      return "margin:$zeroAuto;";
    } else {
      return """margin:${getSizeWithUnit(top, sizeUnit)} ${getSizeWithUnit(right, sizeUnit)} ${getSizeWithUnit(bottom, sizeUnit)} ${getSizeWithUnit(left, sizeUnit)};""";
    }
  }
}
