import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

///TeXViewPadding to manage different types of padding of TeXView.
class TeXViewPadding {
  final TeXViewSizeUnit? sizeUnit;

  /// Top padding.
  final int? top;

  /// Bottom padding.
  final int? bottom;

  /// Right padding.
  final int? right;

  /// Left padding.
  final int? left;

  /// All sides padding and it'll override top, bottom,right and left padding.
  final int? all;

  const TeXViewPadding.all(this.all, {this.sizeUnit})
      : top = null,
        bottom = null,
        right = null,
        left = null;

  const TeXViewPadding.only(
      {this.sizeUnit, this.top, this.bottom, this.right, this.left})
      : all = null;

  /// It'll provide CSS margin code.
  String getPadding() {
    if (all != null) {
      return "padding: ${getSizeWithUnit(all, sizeUnit)};";
    } else {
      return """padding: ${getSizeWithUnit(top, sizeUnit)} ${getSizeWithUnit(right, sizeUnit)} ${getSizeWithUnit(bottom, sizeUnit)} ${getSizeWithUnit(left, sizeUnit)};""";
    }
  }
}
