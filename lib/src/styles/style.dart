import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

/// TeXViewStyle provide an easy interface for styling TeXView which converts dart code to CSS code.
class TeXViewStyle {
  ///Hard coded CSS code.
  final String? cascadingStyleSheets;

  ///TeXViewPadding to manage padding of by using [TeXViewPadding].
  final TeXViewPadding? padding;

  ///TeXViewMargin to manage margin of View by using [TeXViewMargin].
  final TeXViewMargin? margin;

  ///[TeXViewSizeUnit] for [height], [width] and [elevation].
  final TeXViewSizeUnit? sizeUnit;

  ///Height of View.
  final int? height;

  ///Width of view.
  final int? width;

  ///Elevation of View.
  final int? elevation;

  ///Color of content(fonts) within the View.
  final Color? contentColor;

  ///Background color of View.
  final Color? backgroundColor;

  ///Styling of border by using [TeXViewBorder] class.
  final TeXViewBorder? border;

  ///Managing radius of border by using [TeXViewBorderRadius] class.
  final TeXViewBorderRadius? borderRadius;

  /// Text alignment within TeXView.
  final TeXViewTextAlign? textAlign;

  /// Font styling for TeXView widgets
  final TeXViewFontStyle? fontStyle;

  const TeXViewStyle(
      {this.padding,
      this.margin,
      this.sizeUnit,
      this.height,
      this.width,
      this.elevation,
      this.contentColor,
      this.backgroundColor,
      this.border,
      this.borderRadius,
      this.textAlign,
      this.fontStyle})
      : cascadingStyleSheets = null;

  /// Styling TeXView with hard coded CSS e.g. "color:green;background-color:red".
  const TeXViewStyle.fromCSS(this.cascadingStyleSheets)
      : padding = null,
        margin = null,
        sizeUnit = null,
        height = null,
        width = null,
        elevation = null,
        contentColor = null,
        backgroundColor = null,
        border = null,
        borderRadius = null,
        fontStyle = null,
        textAlign = null;

  String? initStyle() {
    return cascadingStyleSheets ??
        """$teXViewDefaultStyle ${padding?.getPadding() ?? ""}${margin?.getMargin() ?? ""}${borderRadius?.getRadius() ?? ""}${border?.getBorder() ?? ""}${height != null ? "height: ${getSizeWithUnit(height, sizeUnit)};" : ""}${width != null ? "width: ${getSizeWithUnit(width, sizeUnit)};" : ""}${elevation != null ? "box-shadow: ${getElevation(elevation, sizeUnit)};" : ""}${contentColor != null ? "color: ${getColor(contentColor)};" : ""}${backgroundColor != null ? "background-color: ${getColor(backgroundColor)};" : ""}${textAlign != null ? "text-align: ${TeXViewTextAlignHelper.getValue(textAlign)};" : ""}${fontStyle?.initFontStyle() ?? ""}""";
  }
}
