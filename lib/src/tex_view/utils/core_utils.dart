import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_tex/src/tex_view/tex_view.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';

/// A small initial height for the TeXView widget before its actual content is rendered.
///
/// This minimal non-zero height allows the framework to lay out the widget initially
/// without a height constraint error, while preventing visible layout jumps until the
/// actual content height is calculated by the JS bridge.
const double initialHeight = 1;

/// Asynchronously serializes the complete [TeXView] widget tree into a JSON string.
///
/// For lightweight payloads or web targets, serialization runs synchronously. For
/// larger trees on native platforms, encoding is offloaded to a background isolate via
/// [compute] to keep the UI thread smooth.
///
/// Returns a JSON string containing:
/// - `meta`: The root element metadata (tag, class, id).
/// - `data`: The serialized child widgets.
/// - `style`: The compiled CSS string.
Future<String> getRawDataAsync(TeXView teXView) async {
  final Map<String, dynamic> dataMap = {
    'meta': const TeXViewWidgetMeta(
      tag: 'div',
      classList: 'tex-view',
      node: Node.root,
    ).toJson(),
    'data': teXView.child.toJson(),
    'style': teXView.style?.initStyle() ?? teXViewDefaultStyle,
  };

  // On web, isolates are not supported; serialize directly.
  // On native platforms, offload trees exceeding the complexity threshold.
  if (kIsWeb || _calculateComplexity(dataMap['data']) < 50) {
    return jsonEncode(dataMap);
  }

  return compute(jsonEncode, dataMap);
}

/// Recursively estimates the node count in the serialized widget hierarchy.
int _calculateComplexity(dynamic node) {
  int count = 1;
  if (node is Map) {
    if (node.containsKey('data')) {
      count += _calculateComplexity(node['data']);
    }
  } else if (node is List) {
    for (final child in node) {
      count += _calculateComplexity(child);
    }
  }
  return count;
}

/// The default CSS styling for the TeXView container.
///
/// Enforces `overflow: hidden` to prevent scrollbars within the view itself,
/// and sets width to 100% to fill the parent container.
const String teXViewDefaultStyle = "overflow: hidden; width: 100%;";
