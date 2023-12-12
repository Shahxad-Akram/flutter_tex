import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewVideo extends TeXViewWidget {
  /// Uri for Image.
  final String url;

  final String _type;

  const TeXViewVideo.youtube(this.url) : _type = 'tex-view-video-youtube';

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(tag: 'div', classList: _type, node: Node.leaf);
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': _getWidget(),
        'style': "max-width: 100%; max-height: 100%; $teXViewDefaultStyle",
      };

  String _getWidget() {
    return """<iframe width="100%" height="100%" frameborder="0" allowfullscreen
    src="https://www.youtube.com/embed/${Uri.parse(url).queryParameters['v']}"
    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"></iframe>""";
  }
}
