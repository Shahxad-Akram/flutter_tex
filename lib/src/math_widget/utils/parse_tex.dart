import 'package:flutter_tex/flutter_tex.dart';

/// A class representing a segment of TeX input.
class TeXSegment {
  /// The text content of the segment.
  final String text;

  /// The type of the segment (text, inline, or display).
  final TeXSegmentType type;

  /// Creates a new [TeXSegment] with the given [text] and [type].
  TeXSegment(this.text, this.type);
}

// Display delimiters must precede inline delimiters so multi-character
// patterns ($$, \[) take precedence over single-character ones ($, \().
final RegExp _latexRegex = RegExp(
  "${TeXDelimiter.displayDollar.delimiter}|"
  "${TeXDelimiter.displayBrackets.delimiter}|"
  "${TeXDelimiter.inlineDollar.delimiter}|"
  "${TeXDelimiter.inlineBrackets.delimiter}",
);

/// Parses a raw string containing TeX markup into an ordered sequence of [TeXSegment]s.
///
/// Delimited math blocks are classified as either [TeXSegmentType.display] or
/// [TeXSegmentType.inline], and surrounding plain text is preserved as [TeXSegmentType.text].
List<TeXSegment> parseTeX(String latexString) {
  final List<TeXSegment> parsedTeXSegments = [];
  int lastEnd = 0;

  for (final RegExpMatch match in _latexRegex.allMatches(latexString)) {
    // Preserve preceding plain text segment.
    if (match.start > lastEnd) {
      parsedTeXSegments.add(
        TeXSegment(
          latexString.substring(lastEnd, match.start),
          TeXSegmentType.text,
        ),
      );
    }

    // Capture groups correspond to inner expressions:
    // group(2): $$...$$, group(4): \[...\], group(6): $...$, group(8): \(...\)
    final String? displayDollar = match.group(2);
    final String? displayBracket = match.group(4);
    final String? inlineDollar = match.group(6);
    final String? inlineBracket = match.group(8);

    if (displayDollar != null && displayDollar.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(displayDollar, TeXSegmentType.display));
    } else if (displayBracket != null && displayBracket.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(displayBracket, TeXSegmentType.display));
    } else if (inlineDollar != null && inlineDollar.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(inlineDollar, TeXSegmentType.inline));
    } else if (inlineBracket != null && inlineBracket.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(inlineBracket, TeXSegmentType.inline));
    }

    lastEnd = match.end;
  }

  // Append any remaining text after the final math segment.
  if (lastEnd < latexString.length) {
    parsedTeXSegments.add(
      TeXSegment(
        latexString.substring(lastEnd),
        TeXSegmentType.text,
      ),
    );
  }

  return parsedTeXSegments;
}