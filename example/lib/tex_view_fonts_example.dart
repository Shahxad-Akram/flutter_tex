import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewFontsExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  TeXViewFontsExamples(
      {this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("TeXView Fonts"),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          TeXView(
              fonts: [
                TeXViewFont(fontFamily: 'army', src: 'fonts/Army.ttf'),
                TeXViewFont(fontFamily: 'budhrg', src: 'fonts/Budhrg.ttf'),
                TeXViewFont(fontFamily: 'celtg', src: 'fonts/CELTG.ttf'),
                TeXViewFont(fontFamily: 'hillock', src: 'fonts/hillock.ttf'),
                TeXViewFont(fontFamily: 'intimacy', src: 'fonts/intimacy.ttf'),
                TeXViewFont(
                    fontFamily: 'sansation_light',
                    src: 'fonts/SansationLight.ttf'),
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
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                elevation: 10,
                borderRadius: TeXViewBorderRadius.all(25),
                border: TeXViewBorder.all(
                  TeXViewBorderDecoration(
                      borderColor: Colors.blue,
                      borderStyle: TeXViewBorderStyle.Solid,
                      borderWidth: 5),
                ),
                backgroundColor: Colors.white,
              ),
              loadingWidgetBuilder: (context) => Center(
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
        ],
      ),
    );
  }

  static TeXViewWidget _teXViewWidget(String title, String fontFamily) {
    return TeXViewColumn(
        style: TeXViewStyle(
            margin: TeXViewMargin.all(5),
            padding: TeXViewPadding.all(5),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                borderStyle: TeXViewBorderStyle.Groove,
                borderColor: Colors.green))),
        children: [
          TeXViewDocument(title,
              style: TeXViewStyle(
                  fontStyle: TeXViewFontStyle(
                      fontSize: 20,
                      sizeUnit: TeXViewSizeUnit.Pt,
                      fontFamily: fontFamily),
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  textAlign: TeXViewTextAlign.Center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto())),
        ]);
  }
}
