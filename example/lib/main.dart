import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex_example/tex_view_document_examples.dart';
import 'package:flutter_tex_example/tex_view_fonts_examples.dart';
import 'package:flutter_tex_example/tex_view_image_video_example.dart';
import 'package:flutter_tex_example/tex_view_ink_well_example.dart';
import 'package:flutter_tex_example/tex_view_markdown_example.dart';
import 'package:flutter_tex_example/tex_view_quiz_example.dart';

main() async {
  runApp(FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TeXViewFullExample(),
    );
  }
}

class TeXViewFullExample extends StatefulWidget {
  @override
  _TeXViewFullExampleState createState() => _TeXViewFullExampleState();
}

class _TeXViewFullExampleState extends State<TeXViewFullExample> {
  int radVal = 0;

  TeXViewRenderingEngine renderingEngine;

  @override
  Widget build(BuildContext context) {
    renderingEngine = radVal == 0
        ? TeXViewRenderingEngine.katex()
        : TeXViewRenderingEngine.mathjax();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter TeX (Demo)"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "assets/flutter_tex_banner.png",
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          RadioListTile(
            value: 0,
            groupValue: radVal,
            onChanged: (val) {
              setState(() {
                this.radVal = val;
              });
            },
            title: Text("Katex"),
            subtitle: Text("RenderingEngine for Fast Rendering"),
          ),
          RadioListTile(
            value: 1,
            groupValue: radVal,
            onChanged: (val) {
              setState(() {
                this.radVal = val;
              });
            },
            title: Text("MathJax"),
            subtitle: Text("RenderingEngine for Quality Rendering"),
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          getExampleButton(
              context,
              'Quiz Example',
              TeXViewQuizExample(
                renderingEngine: renderingEngine,
              )),
          getExampleButton(
              context,
              'TeX Examples',
              TeXViewDocumentExamples(
                renderingEngine: renderingEngine,
              )),
          getExampleButton(
              context,
              'Markdown Examples',
              TeXViewMarkdownExamples(
                renderingEngine: renderingEngine,
              )),
          getExampleButton(
              context,
              'Custom Fonts Examples',
              TeXViewFontsExamples(
                renderingEngine: renderingEngine,
              )),
          getExampleButton(
              context,
              'Image & Video Example',
              TeXViewImageVideoExample(
                renderingEngine: renderingEngine,
              )),
          getExampleButton(
              context,
              'Inkwell Example',
              TeXViewInkWellExample(
                renderingEngine: renderingEngine,
              )),
        ],
      ),
    );
  }

  getExampleButton(BuildContext context, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        elevation: 5,
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class TeXViewMiniExample extends StatefulWidget {
  @override
  _TeXViewMiniExampleState createState() => _TeXViewMiniExampleState();
}

class _TeXViewMiniExampleState extends State<TeXViewMiniExample> {
  @override
  Widget build(BuildContext context) {
    return TeXView(
        child: TeXViewColumn(children: [
          TeXViewInkWell(
            id: "id_0",
            child: TeXViewColumn(children: [
              TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
                  style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
              TeXViewContainer(
                child: TeXViewImage.network(
                    'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
                style: TeXViewStyle(
                  margin: TeXViewMargin.all(10),
                  borderRadius: TeXViewBorderRadius.all(20),
                ),
              ),
              TeXViewDocument(r"""<p>                                
                           When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                           $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                  style: TeXViewStyle.fromCSS(
                      'padding: 15px; color: white; background: green'))
            ]),
          )
        ]),
        style: TeXViewStyle(
          elevation: 10,
          borderRadius: TeXViewBorderRadius.all(25),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderColor: Colors.blue,
              borderStyle: TeXViewBorderStyle.Solid,
              borderWidth: 5)),
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
            ));
  }
}
