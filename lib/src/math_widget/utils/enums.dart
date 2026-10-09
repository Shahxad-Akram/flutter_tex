/// The type of input math to be rendered.
enum MathInputType {
  /// TeX input.
  teX("teX"),

  /// MathML input.
  mathML("mathML"),

  /// AsciiMath input.
  asciiMath("asciiMath");

  final String type;

  const MathInputType(this.type);
}

/// The type of the TeX segment which can be either [text], [inline] or [display].
enum TeXSegmentType {
  /// Text segment.
  text,

  /// Inline math segment.
  inline,

  /// Display math segment.
  display,
}

/// The delimiter used to identify the TeX segment.
enum TeXDelimiter {
  /// Inline brackets `\(...\)`
  inlineBrackets(r"(\\\((.*?)\\\))"),

  /// Inline dollar `$...$`
  inlineDollar(r"(\$(.*?)\$)"),

  /// Display brackets `\[...\]`
  displayBrackets(r"(\\\[(.*?)\\\])"),

  /// Display dollar `$$...$$`
  displayDollar(r"(\$\$(.*?)\$\$)");

  final String delimiter;

  const TeXDelimiter(this.delimiter);
}
