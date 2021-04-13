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
      : this.zeroAuto = null,
        this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  const TeXViewMargin.only(
      {this.sizeUnit, this.top, this.bottom, this.right, this.left})
      : this.all = null,
        this.zeroAuto = null;

  const TeXViewMargin.zeroAuto()
      : this.zeroAuto = "0 auto",
        this.sizeUnit = null,
        this.all = null,
        this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  /// It'll provide CSS margin code.
  String getMargin() {
    if (this.all != null) {
      return "margin:${getSizeWithUnit(all, sizeUnit)};";
    } else if (this.zeroAuto != null) {
      return "margin:${this.zeroAuto};";
    } else {
      return """margin:${getSizeWithUnit(top, sizeUnit)} ${getSizeWithUnit(right, sizeUnit)} ${getSizeWithUnit(bottom, sizeUnit)} ${getSizeWithUnit(left, sizeUnit)};""";
    }
  }
}
