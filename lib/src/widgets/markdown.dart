import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';
import 'package:markdown/markdown.dart' hide Node;

class TeXViewMarkdown extends TeXViewWidget {
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
}
