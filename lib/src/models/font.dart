class TeXViewFont {
  /// Assign a font-family name.
  final String fontFamily;

  /// Font location e.g. 'fonts/font_name.ttf'
  final String src;

  const TeXViewFont({required this.fontFamily, required this.src});

  Map toJson() => {
        'font_family': fontFamily,
        'src': src,
      };
}
