import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewImage extends TeXViewWidget {
  final String? id;

  /// Uri for Image.
  final String imageUri;

  final String _type;

  const TeXViewImage.asset(this.imageUri, {this.id})
      : this._type = 'tex-view-asset-image';

  const TeXViewImage.network(this.imageUri, {this.id})
      : this._type = 'tex-view-network-image';

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        id: this.id, tag: 'img', classList: _type, node: Node.Leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': this.imageUri,
        'style': "max-width: 100%; max-height: 100%; " + teXViewDefaultStyle,
      };
}
