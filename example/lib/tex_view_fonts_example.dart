import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewFontsExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewFontsExamples(
      {Key? key, this.renderingEngine = const TeXViewRenderingEngine.katex()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeXView Fonts"),
      ),
      body: TeXView(
          fonts: const [
            TeXViewFont(fontFamily: 'army', src: 'fonts/Army.ttf'),
            TeXViewFont(fontFamily: 'budhrg', src: 'fonts/Budhrg.ttf'),
            TeXViewFont(fontFamily: 'celtg', src: 'fonts/CELTG.ttf'),
            TeXViewFont(fontFamily: 'hillock', src: 'fonts/hillock.ttf'),
            TeXViewFont(fontFamily: 'intimacy', src: 'fonts/intimacy.ttf'),
            TeXViewFont(
                fontFamily: 'sansation_light', src: 'fonts/SansationLight.ttf'),
            TeXViewFont(fontFamily: 'slenmini', src: 'fonts/slenmini.ttf'),
            TeXViewFont(
                fontFamily: 'subaccuz_regular',
                src: 'fonts/SubaccuzRegular.ttf'),
          ],
          renderingEngine: renderingEngine,
          child: TeXViewColumn(children: [
            _teXViewWidget("Army", 'army'),
            _teXViewWidget("Budhrg", 'budhrg'),
            _teXViewWidget("CELTG", 'celtg'),
            _teXViewWidget("Hillock", 'hillock'),
            _teXViewWidget("intimacy", 'intimacy'),
            _teXViewWidget("Sansation Light", 'sansation_light'),
            _teXViewWidget("Slenmini", 'slenmini'),
            _teXViewWidget("Subaccuz Regular'", 'subaccuz_regular')
          ]),
          style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
            elevation: 10,
            borderRadius: TeXViewBorderRadius.all(25),
            border: TeXViewBorder.all(
              TeXViewBorderDecoration(
                  borderColor: Colors.blue,
                  borderStyle: TeXViewBorderStyle.solid,
                  borderWidth: 5),
            ),
            backgroundColor: Colors.white,
          ),
          loadingWidgetBuilder: (context) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering...")
                  ],
                ),
              )),
    );
  }

  static TeXViewWidget _teXViewWidget(String title, String fontFamily) {
    return TeXViewColumn(
        style: const TeXViewStyle(
            margin: TeXViewMargin.all(5),
            padding: TeXViewPadding.all(5),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                borderStyle: TeXViewBorderStyle.groove,
                borderColor: Colors.green))),
        children: [
          TeXViewDocument(title,
              style: TeXViewStyle(
                  fontStyle: TeXViewFontStyle(
                      fontSize: 20,
                      sizeUnit: TeXViewSizeUnit.pt,
                      fontFamily: fontFamily),
                  padding: const TeXViewPadding.all(10),
                  borderRadius: const TeXViewBorderRadius.all(10),
                  textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: const TeXViewMargin.zeroAuto())),
        ]);
  }
}
