import 'package:flutter/material.dart';

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
  TeXViewBorderDecoration top;
  TeXViewBorderDecoration bottom;
  TeXViewBorderDecoration right;
  TeXViewBorderDecoration left;
  TeXViewBorderDecoration all;

  TeXViewBorder.all(this.all);

  TeXViewBorder.only({this.top, this.bottom, this.right, this.left});

  String getBorder() {
    return this.all == null
        ? """
    border-top: ${top?.getBorderDecoration()};
    border-bottom: ${bottom?.getBorderDecoration()};
    border-right: ${right?.getBorderDecoration()};
    border-left: ${left?.getBorderDecoration()};
    """
        : """
        border: ${all?.getBorderDecoration()};
    """;
  }
}

class TeXViewBorderDecoration {
  int borderWidth;
  TeXViewBorderStyle borderStyle;
  Color borderColor;

  TeXViewBorderDecoration(
      {this.borderWidth, this.borderStyle, this.borderColor});

  String getBorderDecoration() {
    return "${this.borderWidth}px ${_TeXViewBorderStyleHelper.getValue(borderStyle)} ${_getColor(this.borderColor)}";
  }
}

class TeXViewBorderRadius {
  LengthUnit lengthUnit;
  int topLeft;
  int topRight;
  int bottomRight;
  int bottomLeft;
  int all;

  TeXViewBorderRadius.all(this.all, {this.lengthUnit});

  TeXViewBorderRadius.only(
      {this.lengthUnit,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft});

  String getRadius() {
    return this.all != null
        ? """
          border-radius: $all${_UnitHelper.getValue(lengthUnit)};
        """
        : """
          border-radius: ${_getRadiusValue(topLeft)} ${_getRadiusValue(topRight)} ${_getRadiusValue(bottomRight)} ${_getRadiusValue(bottomLeft)};
        """;
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
  LengthUnit lengthUnit;

  /// Top margin.
  int top;

  /// Bottom margin.
  int bottom;

  /// Right margin.
  int right;

  /// Left margin.
  int left;

  /// All sides margin and it'll override top, bottom,right and left margins.
  int all;

  String zeroAuto;

  TeXViewMargin.all(this.all, {this.lengthUnit});

  TeXViewMargin.only(
      {this.lengthUnit, this.top, this.bottom, this.right, this.left});

  TeXViewMargin.zeroAuto() {
    this.zeroAuto = "0 auto";
  }

  /// It'll provide CSS margin code.
  String getMargin() {
    if (this.all != null) {
      return "margin: ${_getLength(all, lengthUnit)};";
    } else if (this.zeroAuto != null) {
      return "margin: ${this.zeroAuto};";
    } else {
      return """
      margin: ${_getLength(top, lengthUnit)} ${_getLength(right, lengthUnit)} ${_getLength(bottom, lengthUnit)} ${_getLength(left, lengthUnit)} ;
      """;
    }
  }
}

///TeXViewPadding to manage different types of padding of TeXView.
class TeXViewPadding {
  LengthUnit lengthUnit;

  /// Top padding.
  int top;

  /// Bottom padding.
  int bottom;

  /// Right padding.
  int right;

  /// Left padding.
  int left;

  /// All sides padding and it'll override top, bottom,right and left padding.
  int all;

  TeXViewPadding.all(this.all, {this.lengthUnit});

  TeXViewPadding.only(
      {this.lengthUnit, this.top, this.bottom, this.right, this.left});

  /// It'll provide CSS margin code.
  String getPadding() {
    if (this.all != null) {
      return "padding: ${_getLength(all, lengthUnit)};";
    } else {
      return """
     padding: ${_getLength(top, lengthUnit)} ${_getLength(right, lengthUnit)} ${_getLength(bottom, lengthUnit)} ${_getLength(left, lengthUnit)} ;
      """;
    }
  }
}

/// TeXViewStyle provide an easy interface for styling TeXView which converts dart code to CSS code.
class TeXViewStyle {
  ///Hard coded CSS code.
  String cascadingStyleSheets;

  ///TeXViewPadding to manage padding of by using [TeXViewPadding].
  TeXViewPadding padding;

  ///TeXViewMargin to manage margin of View by using [TeXViewMargin].
  TeXViewMargin margin;

  ///[LengthUnit] either px, % or em.
  LengthUnit lengthUnit;

  ///Height of View.
  int height;

  ///Width of view.
  int width;

  ///Elevation of View.
  int elevation;

  ///Color of content(fonts) within the View.
  Color contentColor;

  ///Background color of View.
  Color backgroundColor;

  ///Styling of border by using [TeXViewBorder] class.
  TeXViewBorder border;

  ///Managing radius of border by using [TeXViewBorderRadius] class.
  TeXViewBorderRadius borderRadius;

  /// Text alignment within TeXView.
  TeXViewTextAlign textAlign;

  TeXViewStyle(
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
      this.textAlign});

  /// Styling TeXView with hard coded CSS e.g. "color:green;background-color:red".
  TeXViewStyle.fromCSS(this.cascadingStyleSheets);

  String initStyle() {
    return cascadingStyleSheets == null
        ? """
    ${padding?.getPadding() ?? ""}
    ${margin?.getMargin() ?? ""}
    ${borderRadius?.getRadius() ?? ""};
    ${border?.getBorder() ?? ""};
    height: ${height != null ? _getLength(height, lengthUnit) : ""};
    width: ${width != null ? _getLength(width, lengthUnit) : ""};
    box-shadow: ${elevation != null ? _getElevation(elevation, lengthUnit) : ""};
    color: ${contentColor != null ? _getColor(contentColor) : ""};
    background-color: ${backgroundColor != null ? _getColor(backgroundColor) : ""};
    text-align: ${_TeXViewTextAlignHelper.getValue(textAlign)}
    """
        : cascadingStyleSheets;
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
