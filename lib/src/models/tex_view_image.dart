import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/style/tex_view_style.dart';

class TeXViewImage extends TeXViewWidget {
  /// Uri for Image.
  final String imageUri;

  final String _type;

  const TeXViewImage.asset(this.imageUri) : this._type = 'tex-view-asset-image';

  const TeXViewImage.network(this.imageUri)
      : this._type = 'tex-view-network-image';

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(tag: 'img', type: _type, node: Node.Leaf);
  }

  @override
  void onTapManager(String id) {}

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': this.imageUri,
        'style': "max-width: 100%; max-height: 100%; " + teXViewDefaultStyle,
      };
}
