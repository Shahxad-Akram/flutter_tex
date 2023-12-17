import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewImageVideoExample extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewImageVideoExample(
      {super.key, this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TeXView Image & Video"),
      ),
      body: TeXView(
          renderingEngine: renderingEngine,
          child: const TeXViewColumn(children: [
            TeXViewDocument(
                r"""<h2>Flutter \( \rm\\TeX \) Image Example</h2>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.center)),
            TeXViewDocument('Image Loaded From Assets'),
            TeXViewContainer(
              child: TeXViewImage.asset('assets/flutter_tex_banner.png'),
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                borderRadius: TeXViewBorderRadius.all(20),
              ),
            ),
            TeXViewDocument('Video loaded form Youtube link'),
            TeXViewVideo.youtube(
                "https://www.youtube.com/watch?v=YiNbVEXV_NM&lc=Ugyg4ljzrK0D6YfrO854AaABAg"),
            TeXViewDocument(
                'Image Loaded From Network, this may take some time according to your network speed'),
            TeXViewContainer(
              child: TeXViewImage.network(
                  'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                borderRadius: TeXViewBorderRadius.all(20),
              ),
            ),
          ]),
          style: const TeXViewStyle(
            margin: TeXViewMargin.all(5),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(
              TeXViewBorderDecoration(
                  borderColor: Colors.blue,
                  borderStyle: TeXViewBorderStyle.solid,
                  borderWidth: 5),
            ),
            backgroundColor: Colors.white,
          ),
          loadingWidgetBuilder: (context) => const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering...")
                  ],
                ),
              )),
    );
  }
}
