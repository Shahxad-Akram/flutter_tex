import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TeXViewImage Example"),
      ),
      body: ListView(
        children: [
          TeXView(
              showLoadingWidget: true,
              child: TeXViewColumn(children: [
                TeXViewDocument(
                    r"""<h2>Flutter \( \rm\\TeX \) Image Example</h2>""",
                    style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
                TeXViewDocument('Image Loaded From Assets'),
                TeXViewContainer(
                  child: TeXViewImage.asset('assets/flutter_tex_banner.png'),
                  style: TeXViewStyle(
                    margin: TeXViewMargin.all(10),
                    borderRadius: TeXViewBorderRadius.all(20),
                  ),
                ),
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
              style: TeXViewStyle(
                margin: TeXViewMargin.all(5),
                padding: TeXViewPadding.all(10),
                borderRadius: TeXViewBorderRadius.all(10),
                border: TeXViewBorder.all(
                  TeXViewBorderDecoration(
                      borderColor: Colors.blue,
                      borderStyle: TeXViewBorderStyle.Solid,
                      borderWidth: 5),
                ),
                backgroundColor: Colors.white,
              ),
              loadingWidget: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering...!")
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
