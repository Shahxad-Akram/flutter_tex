import 'dart:ui';

import 'package:flutter_tex/flutter_tex.dart';

/// A default CSS style applied to the root TeXView container.
///
/// `position: relative;` is important for ensuring that absolutely positioned
/// children within the view are positioned relative to the container itself.
String teXViewDefaultStyle = "position: relative;";

/// Converts a Flutter [Color] object into a CSS `rgba()` string.
///
/// If the color is null, it defaults to transparent black.
String getColor(Color? color) {
  return "rgba(${((color?.r ?? 0) * 255).toInt()}, ${((color?.g ?? 0) * 255).toInt()}, ${((color?.b ?? 0) * 255).toInt()}, ${color?.a ?? 0})";
}

/// Generates a CSS `box-shadow` value to simulate elevation.
///
/// Uses [elevation] to scale blur and spread offsets, formatted with [sizeUnit].
String getElevation(int? elevation, TeXViewSizeUnit? sizeUnit) {
  final int elev = elevation ?? 0;
  final String unit = UnitHelper.getValue(sizeUnit);
  return "0 ${elev * 1}$unit ${elev * 2}$unit 0 rgba(0,0,0,0.2)";
}

/// Combines a numerical [value] with its [sizeUnit] to create a CSS size string.
///
/// For example, `getSizeWithUnit(10, TeXViewSizeUnit.pixels)` returns `"10px"`.
/// Defaults to 0 if the value is null.
String getSizeWithUnit(int? value, TeXViewSizeUnit? sizeUnit) {
  return (value ?? 0).toString() + UnitHelper.getValue(sizeUnit);
}
