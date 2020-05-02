import 'package:flutter/material.dart';
import 'package:flutter_tex/src/utils/enums.dart';

String _getLength(int value, LengthUnit lengthUnit) {
  return "${value == 0 ? "auto" : value.toString() + "${UnitHelper.getValue(lengthUnit)}"}";
}

String _getColor(Color color) {
  return "rgba(${color?.red}, ${color?.green}, ${color?.blue}, ${color?.alpha})";
}

String _getElevation(int elevation, LengthUnit lengthUnit) {
  return "0 ${elevation ?? 0 * 1}${UnitHelper.getValue(lengthUnit)} ${elevation ?? 0 * 2}${UnitHelper.getValue(lengthUnit)} 0 rgba(0,0,0,0.2)";
}

class TeXViewMargin {
  LengthUnit lengthUnit;
  int top;
  int bottom;
  int right;
  int left;
  int all;

  TeXViewMargin(
      {this.lengthUnit,
      this.top,
      this.bottom,
      this.right,
      this.left,
      this.all});

  String getMargin() {
    return """
      margin-top: ${_getLength(top, lengthUnit)};
      margin-bottom: ${_getLength(bottom, lengthUnit)};
      margin-right: ${_getLength(right, lengthUnit)};
      margin-left: ${_getLength(left, lengthUnit)};
      margin: ${_getLength(all, lengthUnit)};
    """;
  }
}

class TeXViewPadding {
  LengthUnit lengthUnit;
  int top;
  int bottom;
  int right;
  int left;
  int all;

  TeXViewPadding(
      {this.lengthUnit,
      this.top,
      this.bottom,
      this.right,
      this.left,
      this.all});

  String getPadding() {
    return """
      padding-top: ${_getLength(top, lengthUnit)};
      padding-bottom: ${_getLength(bottom, lengthUnit)};
      padding-right: ${_getLength(right, lengthUnit)};
      padding-left: ${_getLength(left, lengthUnit)};
      padding: ${_getLength(all, lengthUnit)};
    """;
  }
}

/// TeXViewStyle provide an easy interface for styling TeXView which converts dart code to CSS code.
class TeXViewStyle {
  String cascadingStyleSheets;
  TeXViewPadding padding;
  TeXViewMargin margin;
  LengthUnit lengthUnit;
  int height;
  int width;
  int elevation;
  Color contentColor;
  Color backgroundColor;
  int borderRadius;
  double transition;

  TeXViewStyle(
      {this.padding,
      this.margin,
      this.lengthUnit,
      this.height,
      this.width,
      this.elevation,
      this.contentColor,
      this.backgroundColor,
      this.borderRadius,
      this.transition});

  TeXViewStyle.fromCSS(String cascadingStyleSheets);

  String initStyle() {
    return cascadingStyleSheets == null
        ? """
    ${padding?.getPadding()}
    ${margin?.getMargin()}
    height: ${_getLength(height, lengthUnit)};
    width: ${_getLength(width, lengthUnit)};
    box-shadow: ${_getElevation(elevation, lengthUnit)};
    border-radius:${_getLength(borderRadius, lengthUnit)};
    color: ${_getColor(contentColor)};
    background-color: ${_getColor(backgroundColor)};
    transition: ${transition}s;
    """
        : cascadingStyleSheets;
  }
}
