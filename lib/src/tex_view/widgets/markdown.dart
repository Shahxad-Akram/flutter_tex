import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';
import 'package:markdown/markdown.dart' hide Node;

/// A widget that renders Markdown content, including support for embedded TeX code.
///
/// This widget uses the `markdown` package to convert Markdown to HTML, which is then
/// rendered by the TeXView engine. This allows for rich text formatting combined with
/// mathematical equations.
class TeXViewMarkdown extends TeXViewWidget {
  /// The raw string containing Markdown and TeX code.
  ///
  /// Example: `# Title\nThis is a **bold** text with math: $E=mc^2$`
  final String markdown;

  /// The style to apply to the markdown container.
  final TeXViewStyle? style;

  /// Custom block syntaxes to extend the markdown parsing.
  final Iterable<BlockSyntax> blockSyntaxes;

  /// Custom inline syntaxes to extend the markdown parsing.
  final Iterable<InlineSyntax> inlineSyntaxes;

  /// A set of extensions for the markdown parser (e.g., GitHub Flavored Markdown).
  final ExtensionSet? extensionSet;

  /// A resolver for link URLs.
  final Resolver? linkResolver;

  /// A resolver for image link URLs.
  final Resolver? imageLinkResolver;

  /// Whether to parse only inline syntax (no blocks). Defaults to `false`.
  final bool inlineOnly;

  /// Creates a [TeXViewMarkdown] widget.
  const TeXViewMarkdown(this.markdown,
      {this.style,
      this.blockSyntaxes = const [],
      this.inlineSyntaxes = const [],
      this.extensionSet,
      this.linkResolver,
      this.inlineOnly = false,
      this.imageLinkResolver});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-markdown', node: Node.leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': markdownToHtml(markdown,
            blockSyntaxes: blockSyntaxes,
            extensionSet: extensionSet,
            imageLinkResolver: imageLinkResolver,
            inlineOnly: inlineOnly,
            inlineSyntaxes: inlineSyntaxes,
            linkResolver: linkResolver),
        'style': style?.initStyle() ?? teXViewDefaultStyle,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewMarkdown &&
        other.markdown == markdown &&
        other.style == style &&
        other.inlineOnly == inlineOnly;
  }

  @override
  int get hashCode => Object.hash(markdown, style, inlineOnly);
}
