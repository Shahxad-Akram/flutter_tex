import 'package:flutter_tex/src/models/tex_view_meta.dart';
import 'package:flutter_tex/src/models/tex_view_widget.dart';
import 'package:flutter_tex/src/utils/tex_view_style.dart';

class TeXViewImage extends TeXViewWidget {
  /// Uri for Image.
  final String imageUri;

  final String _type;

  TeXViewImage.asset(this.imageUri) : this._type = 'tex-view-asset-image';

  TeXViewImage.network(this.imageUri) : this._type = 'tex-view-network-image';

  @override
  Map toJson() => {
        'meta': TeXViewWidgetMeta(tag: 'img', type: _type, node: Node.Leaf)
            .toJson(),
        'data': this.imageUri,
        'style': "max-width: 100%; max-height: 100%; " + teXViewDefaultStyle,
      };
}
