import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

/// Specify details that the user can open and close on demand:
class TeXViewDetails implements TeXViewWidget {
  /// Summary for [TeXViewDetails] widget as a [String]
  final String title;

  /// A [TeXViewWidget] as child.
  final TeXViewWidget body;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  const TeXViewDetails({required this.title, required this.body, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'details',
        classList: "tex-view-details",
        node: Node.internalChildren);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': [
          {
            'meta': const TeXViewWidgetMeta(
                    tag: 'summary',
                    classList: 'tex-view-details-title',
                    node: Node.leaf)
                .toJson(),
            'data': title,
            'style': style?.initStyle() ?? teXViewDefaultStyle,
          },
          body.toJson()
        ],
        'style': teXViewDefaultStyle,
      };

  @override
  void onTapCallback(String id) {
    body.onTapCallback(id);
  }
}
