import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that displays an image within a [TeXView].
///
/// This widget supports images from both local assets and network URLs.
class TeXViewImage extends TeXViewWidget {
  /// The URI for the image (either an asset path or a network URL).
  final String imageUri;

  final String _type;

  /// Creates a [TeXViewImage] from a local asset.
  ///
  /// [imageUri] should be the path to the asset (e.g., 'assets/image.png').
  const TeXViewImage.asset(this.imageUri) : _type = 'tex-view-asset-image';

  /// Creates a [TeXViewImage] from a network URL.
  ///
  /// [imageUri] should be the full URL of the image.
  const TeXViewImage.network(this.imageUri) : _type = 'tex-view-network-image';

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(tag: 'img', classList: _type, node: Node.leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': imageUri,
        'style': "max-width: 100%; max-height: 100%; $teXViewDefaultStyle",
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewImage &&
        other.imageUri == imageUri &&
        other._type == _type;
  }

  @override
  int get hashCode => Object.hash(imageUri, _type);
}
