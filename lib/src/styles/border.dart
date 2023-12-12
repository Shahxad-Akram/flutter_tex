import 'dart:ui';

import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewBorder {
  final TeXViewBorderDecoration? top;
  final TeXViewBorderDecoration? bottom;
  final TeXViewBorderDecoration? right;
  final TeXViewBorderDecoration? left;
  final TeXViewBorderDecoration? all;

  const TeXViewBorder.all(this.all)
      : top = null,
        bottom = null,
        right = null,
        left = null;

  const TeXViewBorder.only({this.top, this.bottom, this.right, this.left})
      : all = null;

  String getBorder() {
    return all == null
        ? """border-top:${top?.getBorderDecoration()};border-bottom:${bottom?.getBorderDecoration()};border-right:${right?.getBorderDecoration()};border-left:${left?.getBorderDecoration()};"""
        : """border:${all?.getBorderDecoration()};""";
  }
}

class TeXViewBorderDecoration {
  final int? borderWidth;
  final TeXViewBorderStyle? borderStyle;
  final Color? borderColor;

  const TeXViewBorderDecoration(
      {this.borderWidth, this.borderStyle, this.borderColor});

  String getBorderDecoration() {
    return "${borderWidth}px ${_getTeXViewBorderStyleValue(borderStyle)} ${getColor(borderColor)}";
  }

  static String _getTeXViewBorderStyleValue(
      TeXViewBorderStyle? teXViewBorderStyle) {
    switch (teXViewBorderStyle) {
      case TeXViewBorderStyle.none:
        return "none";

      case TeXViewBorderStyle.hidden:
        return "hidden";

      case TeXViewBorderStyle.dotted:
        return "dotted";

      case TeXViewBorderStyle.dashed:
        return "dashed";

      case TeXViewBorderStyle.solid:
        return "solid";

      case TeXViewBorderStyle.double:
        return "double";

      case TeXViewBorderStyle.groove:
        return "groove";

      case TeXViewBorderStyle.ridge:
        return "ridge";

      case TeXViewBorderStyle.inset:
        return "inset";

      case TeXViewBorderStyle.outset:
        return "outset";

      case TeXViewBorderStyle.initial:
        return "initial";

      default:
        return "solid";
    }
  }
}

class TeXViewBorderRadius {
  final TeXViewSizeUnit? sizeUnit;
  final int? topLeft;
  final int? topRight;
  final int? bottomRight;
  final int? bottomLeft;
  final int? all;

  const TeXViewBorderRadius.all(this.all, {this.sizeUnit})
      : topLeft = null,
        topRight = null,
        bottomRight = null,
        bottomLeft = null;

  const TeXViewBorderRadius.only(
      {this.sizeUnit,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft})
      : all = null;

  String getRadius() {
    return all != null
        ? """border-radius:$all${UnitHelper.getValue(sizeUnit)};"""
        : """border-radius:${_getRadiusValue(topLeft)} ${_getRadiusValue(topRight)} ${_getRadiusValue(bottomRight)} ${_getRadiusValue(bottomLeft)};""";
  }

  String _getRadiusValue(int? value) {
    return (value ?? 0).toString() + UnitHelper.getValue(sizeUnit);
  }
}

enum TeXViewBorderStyle {
  none,
  hidden,
  dotted,
  dashed,
  solid,
  double,
  groove,
  ridge,
  inset,
  outset,
  initial
}
