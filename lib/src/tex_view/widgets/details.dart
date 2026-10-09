import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that provides a disclosure widget in which information is visible
/// only when the widget is toggled into an "open" state.
///
/// It corresponds to the HTML `<details>` element.
class TeXViewDetails implements TeXViewWidget {
  /// The summary or title of the details widget.
  ///
  /// This text is always visible and is clicked to toggle the visibility of the [body].
  final String title;

  /// The content hidden inside the details widget.
  ///
  /// This [TeXViewWidget] becomes visible when the user expands the details view.
  final TeXViewWidget body;

  /// The style to apply to the details container.
  final TeXViewStyle? style;

  /// Creates a [TeXViewDetails] widget with a [title] and a [body].
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewDetails &&
        other.title == title &&
        other.body == body &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(title, body, style);
}
