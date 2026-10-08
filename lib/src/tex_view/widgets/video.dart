import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/widget_meta.dart';
import 'package:flutter_tex/src/tex_view/utils/style_utils.dart';

/// A widget that embeds a video (e.g., YouTube) within a [TeXView].
class TeXViewVideo extends TeXViewWidget {
  /// The URL of the video.
  final String url;

  final String _type;

  /// Creates a [TeXViewVideo] that embeds a YouTube video.
  ///
  /// The [url] must be a valid YouTube video URL.
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeXViewVideo && other.url == url && other._type == _type;
  }

  @override
  int get hashCode => Object.hash(url, _type);
}
