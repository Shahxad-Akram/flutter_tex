import 'dart:ui';

import 'package:flutter_tex/src/manifests/style_manifest.dart';
import 'package:flutter_tex/src/style/style_utils.dart';

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
    return "${this.borderWidth}px ${_getTeXViewBorderStyleValue(borderStyle)} ${getColor(this.borderColor)}";
  }

  static String _getTeXViewBorderStyleValue(
      TeXViewBorderStyle teXViewBorderStyle) {
    switch (teXViewBorderStyle) {
      case TeXViewBorderStyle.None:
        return "none";
        break;

      case TeXViewBorderStyle.Hidden:
        return "hidden";
        break;

      case TeXViewBorderStyle.Dotted:
        return "dotted";
        break;

      case TeXViewBorderStyle.Dashed:
        return "dashed";
        break;

      case TeXViewBorderStyle.Solid:
        return "solid";
        break;

      case TeXViewBorderStyle.Double:
        return "double";
        break;

      case TeXViewBorderStyle.Groove:
        return "groove";
        break;

      case TeXViewBorderStyle.Ridge:
        return "ridge";
        break;

      case TeXViewBorderStyle.Inset:
        return "inset";
        break;

      case TeXViewBorderStyle.Outset:
        return "outset";
        break;

      case TeXViewBorderStyle.Initial:
        return "initial";
        break;

      default:
        return "solid";
    }
  }
}

class TeXViewBorderRadius {
  final TeXViewSizeUnit sizeUnit;
  final int topLeft;
  final int topRight;
  final int bottomRight;
  final int bottomLeft;
  final int all;

  const TeXViewBorderRadius.all(this.all, {this.sizeUnit})
      : this.topLeft = null,
        this.topRight = null,
        this.bottomRight = null,
        this.bottomLeft = null;

  const TeXViewBorderRadius.only(
      {this.sizeUnit,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft})
      : this.all = null;

  String getRadius() {
    return this.all != null
        ? """border-radius:$all${UnitHelper.getValue(sizeUnit)};"""
        : """border-radius:${_getRadiusValue(topLeft)} ${_getRadiusValue(topRight)} ${_getRadiusValue(bottomRight)} ${_getRadiusValue(bottomLeft)};""";
  }

  String _getRadiusValue(int value) {
    return "${(value ?? 0).toString() + "${UnitHelper.getValue(sizeUnit)}"}";
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
