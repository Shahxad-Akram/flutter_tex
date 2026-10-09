import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A comprehensive styling class for [TeXView] and its child widgets.
///
/// This class provides a Dart-friendly interface to generate CSS styles,
/// covering properties like padding, margin, dimensions, colors, borders,
/// text alignment, and more.
class TeXViewStyle {
  /// A string of raw, hard-coded CSS to be applied to the widget.
  ///
  /// If this is provided via the [TeXViewStyle.fromCSS] constructor, all other
  /// properties in this class are ignored.
  final String? cascadingStyleSheets;

  /// The padding around the content, defined by [TeXViewPadding].
  final TeXViewPadding? padding;

  /// The margin around the widget, defined by [TeXViewMargin].
  final TeXViewMargin? margin;

  /// The default size unit for [height], [width], and [elevation].
  final TeXViewSizeUnit? sizeUnit;

  /// The height of the widget.
  final int? height;

  /// The width of the widget.
  final int? width;

  /// The elevation of the widget, simulated using a `box-shadow`.
  final int? elevation;

  /// How to handle content that overflows the widget's boundaries.
  final TeXViewOverflow? overflow;

  /// The color of the text content.
  final Color? contentColor;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// The border of the widget, defined by [TeXViewBorder].
  final TeXViewBorder? border;

  /// The radius of the widget's corners, defined by [TeXViewBorderRadius].
  final TeXViewBorderRadius? borderRadius;

  /// The alignment of the text within the widget.
  final TeXViewTextAlign? textAlign;

  /// The font style for the text, defined by [TeXViewFontStyle].
  final TeXViewFontStyle? fontStyle;

  /// Creates a [TeXViewStyle] with individual styling properties.
  const TeXViewStyle({
    this.padding,
    this.margin,
    this.sizeUnit,
    this.height,
    this.width,
    this.elevation,
    this.contentColor,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.overflow,
    this.textAlign,
    this.fontStyle,
  }) : cascadingStyleSheets = null;

  /// Creates a [TeXViewStyle] from a raw CSS string.
  ///
  /// Example: `TeXViewStyle.fromCSS('color: green; background-color: red;')`
  ///
  /// When using this constructor, all other properties of [TeXViewStyle] are ignored.
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
        overflow = null,
        borderRadius = null,
        fontStyle = null,
        textAlign = null;

  /// Compiles all the style properties into a single CSS string.
  ///
  /// This method is used internally to apply the styles to the web content.
  String initStyle() {
    if (cascadingStyleSheets != null) {
      return '$teXViewDefaultStyle $cascadingStyleSheets';
    }

    final styleParts = [
      teXViewDefaultStyle,
      padding?.getPadding(),
      margin?.getMargin(),
      borderRadius?.getRadius(),
      border?.getBorder(),
      if (height != null) 'height: ${getSizeWithUnit(height, sizeUnit)};',
      if (width != null) 'width: ${getSizeWithUnit(width, sizeUnit)};',
      if (elevation != null)
        'box-shadow: ${getElevation(elevation, sizeUnit)};',
      if (contentColor != null) 'color: ${getColor(contentColor)};',
      if (backgroundColor != null)
        'background-color: ${getColor(backgroundColor)};',
      if (textAlign != null)
        'text-align: ${TeXViewTextAlignHelper.getValue(textAlign)};',
      fontStyle?.initFontStyle(),
      if (overflow != null)
        'overflow: ${TeXViewOverflowHelper.getValue(overflow)};',
    ];

    return styleParts.where((s) => s != null && s.isNotEmpty).join(' ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewStyle && other.initStyle() == initStyle();
  }

  @override
  int get hashCode => initStyle().hashCode;
}
