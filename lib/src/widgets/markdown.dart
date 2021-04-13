import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';
import 'package:markdown/markdown.dart' hide Node;

class TeXViewMarkdown extends TeXViewWidget {
  final String? id;

  /// Raw String containing HTML and TEX Code e.g. r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """
  final String markdown;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  final Iterable<BlockSyntax> blockSyntaxes;
  final Iterable<InlineSyntax> inlineSyntaxes;
  final ExtensionSet? extensionSet;
  final Resolver? linkResolver;
  final Resolver? imageLinkResolver;
  final bool inlineOnly;

  const TeXViewMarkdown(this.markdown,
      {this.id,
      this.style,
      this.blockSyntaxes = const [],
      this.inlineSyntaxes = const [],
      this.extensionSet,
      this.linkResolver,
      this.inlineOnly = false,
      this.imageLinkResolver});

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: this.id,
        tag: 'div',
        classList: 'tex-view-markdown',
        node: Node.Leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': markdownToHtml(this.markdown,
            blockSyntaxes: this.blockSyntaxes,
            extensionSet: this.extensionSet,
            imageLinkResolver: this.imageLinkResolver,
            inlineOnly: this.inlineOnly,
            inlineSyntaxes: this.inlineSyntaxes,
            linkResolver: this.linkResolver),
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
      };
}
