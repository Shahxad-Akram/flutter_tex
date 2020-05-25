import 'package:flutter/material.dart';

String teXViewDefaultStyle = "overflow: hidden; position: relative; ";

String _getColor(Color color) {
  return "rgba(${color?.red}, ${color?.green}, ${color?.blue}, ${color?.alpha})";
}

String _getElevation(int elevation, LengthUnit lengthUnit) {
  return "0 ${elevation ?? 0 * 1}${_UnitHelper.getValue(lengthUnit)} ${elevation ?? 0 * 2}${_UnitHelper.getValue(lengthUnit)} 0 rgba(0,0,0,0.2)";
}

String _getLength(int value, LengthUnit lengthUnit) {
  return "${(value ?? 0).toString() + "${_UnitHelper.getValue(lengthUnit)}"}";
}

enum LengthUnit { Pixels, Percent, Em }

class TeXViewBorder {
  final TeXViewBorderDecoration top;
  final TeXViewBorderDecoration bottom;
  final TeXViewBorderDecoration right;
  final TeXViewBorderDecoration left;
  final TeXViewBorderDecoration all;

  const TeXViewBorder.all(this.all)
      : this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  const TeXViewBorder.only({this.top, this.bottom, this.right, this.left})
      : this.all = null;

  String getBorder() {
    return this.all == null
        ? """border-top:${top?.getBorderDecoration()};border-bottom:${bottom?.getBorderDecoration()};border-right:${right?.getBorderDecoration()};border-left:${left?.getBorderDecoration()};"""
        : """border:${all?.getBorderDecoration()};""";
  }
}

class TeXViewBorderDecoration {
  final int borderWidth;
  final TeXViewBorderStyle borderStyle;
  final Color borderColor;

  const TeXViewBorderDecoration(
      {this.borderWidth, this.borderStyle, this.borderColor});

  String getBorderDecoration() {
    return "${this.borderWidth}px ${_TeXViewBorderStyleHelper.getValue(borderStyle)} ${_getColor(this.borderColor)}";
  }
}

class TeXViewBorderRadius {
  final LengthUnit lengthUnit;
  final int topLeft;
  final int topRight;
  final int bottomRight;
  final int bottomLeft;
  final int all;

  const TeXViewBorderRadius.all(this.all, {this.lengthUnit})
      : this.topLeft = null,
        this.topRight = null,
        this.bottomRight = null,
        this.bottomLeft = null;

  const TeXViewBorderRadius.only(
      {this.lengthUnit,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft})
      : this.all = null;

  String getRadius() {
    return this.all != null
        ? """border-radius:$all${_UnitHelper.getValue(lengthUnit)};"""
        : """border-radius:${_getRadiusValue(topLeft)} ${_getRadiusValue(topRight)} ${_getRadiusValue(bottomRight)} ${_getRadiusValue(bottomLeft)};""";
  }

  String _getRadiusValue(int value) {
    return "${(value ?? 0).toString() + "${_UnitHelper.getValue(lengthUnit)}"}";
  }
}

enum TeXViewBorderStyle {
  None,
  Hidden,
  Dotted,
  Dashed,
  Solid,
  Double,
  Groove,
  Ridge,
  Inset,
  Outset,
  Initial
}

///TeXViewMargin to manage different types of margin of TeXView.
class TeXViewMargin {
  final LengthUnit lengthUnit;

  /// Top margin.
  final int top;

  /// Bottom margin.
  final int bottom;

  /// Right margin.
  final int right;

  /// Left margin.
  final int left;

  /// All sides margin and it'll override top, bottom,right and left margins.
  final int all;

  final String zeroAuto;

  const TeXViewMargin.all(this.all, {this.lengthUnit})
      : this.zeroAuto = null,
        this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  const TeXViewMargin.only(
      {this.lengthUnit, this.top, this.bottom, this.right, this.left})
      : this.all = null,
        this.zeroAuto = null;

  const TeXViewMargin.zeroAuto()
      : this.zeroAuto = "0 auto",
        this.lengthUnit = null,
        this.all = null,
        this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  /// It'll provide CSS margin code.
  String getMargin() {
    if (this.all != null) {
      return "margin:${_getLength(all, lengthUnit)};";
    } else if (this.zeroAuto != null) {
      return "margin:${this.zeroAuto};";
    } else {
      return """margin:${_getLength(top, lengthUnit)} ${_getLength(right, lengthUnit)} ${_getLength(bottom, lengthUnit)} ${_getLength(left, lengthUnit)};""";
    }
  }
}

///TeXViewPadding to manage different types of padding of TeXView.
class TeXViewPadding {
  final LengthUnit lengthUnit;

  /// Top padding.
  final int top;

  /// Bottom padding.
  final int bottom;

  /// Right padding.
  final int right;

  /// Left padding.
  final int left;

  /// All sides padding and it'll override top, bottom,right and left padding.
  final int all;

  const TeXViewPadding.all(this.all, {this.lengthUnit})
      : this.top = null,
        this.bottom = null,
        this.right = null,
        this.left = null;

  const TeXViewPadding.only(
      {this.lengthUnit, this.top, this.bottom, this.right, this.left})
      : this.all = null;

  /// It'll provide CSS margin code.
  String getPadding() {
    if (this.all != null) {
      return "padding: ${_getLength(all, lengthUnit)};";
    } else {
      return """padding: ${_getLength(top, lengthUnit)} ${_getLength(right, lengthUnit)} ${_getLength(bottom, lengthUnit)} ${_getLength(left, lengthUnit)};""";
    }
  }
}

/// TeXViewStyle provide an easy interface for styling TeXView which converts dart code to CSS code.
class TeXViewStyle {
  ///Hard coded CSS code.
  final String cascadingStyleSheets;

  ///TeXViewPadding to manage padding of by using [TeXViewPadding].
  final TeXViewPadding padding;

  ///TeXViewMargin to manage margin of View by using [TeXViewMargin].
  final TeXViewMargin margin;

  ///[LengthUnit] either px, % or em.
  final LengthUnit lengthUnit;

  ///Height of View.
  final int height;

  ///Width of view.
  final int width;

  ///Elevation of View.
  final int elevation;

  ///Color of content(fonts) within the View.
  final Color contentColor;

  ///Background color of View.
  final Color backgroundColor;

  ///Styling of border by using [TeXViewBorder] class.
  final TeXViewBorder border;

  ///Managing radius of border by using [TeXViewBorderRadius] class.
  final TeXViewBorderRadius borderRadius;

  /// Text alignment within TeXView.
  final TeXViewTextAlign textAlign;

  const TeXViewStyle(
      {this.padding,
      this.margin,
      this.lengthUnit,
      this.height,
      this.width,
      this.elevation,
      this.contentColor,
      this.backgroundColor,
      this.border,
      this.borderRadius,
      this.textAlign})
      : this.cascadingStyleSheets = null;

  /// Styling TeXView with hard coded CSS e.g. "color:green;background-color:red".
  const TeXViewStyle.fromCSS(this.cascadingStyleSheets)
      : this.padding = null,
        this.margin = null,
        this.lengthUnit = null,
        this.height = null,
        this.width = null,
        this.elevation = null,
        this.contentColor = null,
        this.backgroundColor = null,
        this.border = null,
        this.borderRadius = null,
        this.textAlign = null;

  String initStyle() {
    return cascadingStyleSheets == null
        ? """$teXViewDefaultStyle ${padding?.getPadding() ?? ""}${margin?.getMargin() ?? ""}${borderRadius?.getRadius() ?? ""}${border?.getBorder() ?? ""}${height != null ? "height: " + _getLength(height, lengthUnit) + ";" : ""}${width != null ? "width: " + _getLength(width, lengthUnit) + ";" : ""}${elevation != null ? "box-shadow: " + _getElevation(elevation, lengthUnit) + ";" : ""}${contentColor != null ? "color: " + _getColor(contentColor) + ";" : ""}${backgroundColor != null ? "background-color: " + _getColor(backgroundColor) + ";" : ""}${textAlign != null ? "text-align: " + _TeXViewTextAlignHelper.getValue(textAlign) + ";" : ""}"""
        : teXViewDefaultStyle + cascadingStyleSheets;
  }
}

enum TeXViewTextAlign { Center, Left, Right, Justify }

class _TeXViewBorderStyleHelper {
  static String getValue(TeXViewBorderStyle teXViewBorderStyle) {
    switch (teXViewBorderStyle) {
      case TeXViewBorderStyle.None:
        return "none";
      case TeXViewBorderStyle.Hidden:
        return "hidden";
      case TeXViewBorderStyle.Dotted:
        return "dotted";
      case TeXViewBorderStyle.Dashed:
        return "dashed";
      case TeXViewBorderStyle.Solid:
        return "solid";
      case TeXViewBorderStyle.Double:
        return "double";
      case TeXViewBorderStyle.Groove:
        return "groove";
      case TeXViewBorderStyle.Ridge:
        return "ridge";
      case TeXViewBorderStyle.Inset:
        return "inset";
      case TeXViewBorderStyle.Outset:
        return "outset";
      case TeXViewBorderStyle.Initial:
        return "initial";
      default:
        return "none";
    }
  }
}

class _TeXViewTextAlignHelper {
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

class _UnitHelper {
  static String getValue(LengthUnit unit) {
    switch (unit) {
      case LengthUnit.Pixels:
        return "px";
      case LengthUnit.Percent:
        return "%";
      case LengthUnit.Em:
        return "em";
      default:
        return "px";
    }
  }
}
