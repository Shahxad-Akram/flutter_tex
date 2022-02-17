import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex_example/tex_view_document_example.dart';
import 'package:flutter_tex_example/tex_view_fonts_example.dart';
import 'package:flutter_tex_example/tex_view_image_video_example.dart';
import 'package:flutter_tex_example/tex_view_ink_well_example.dart';
import 'package:flutter_tex_example/tex_view_markdown_example.dart';
import 'package:flutter_tex_example/tex_view_quiz_example.dart';

main() {
  runApp(const FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  const FlutterTeXExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TeXViewFullExample(),
    );
  }
}

class TeXViewFullExample extends StatefulWidget {
  const TeXViewFullExample({Key? key}) : super(key: key);

  @override
  _TeXViewFullExampleState createState() => _TeXViewFullExampleState();
}

class TeXViewMiniExample extends StatefulWidget {
  const TeXViewMiniExample({Key? key}) : super(key: key);

  @override
  _TeXViewMiniExampleState createState() => _TeXViewMiniExampleState();
}

class _TeXViewFullExampleState extends State<TeXViewFullExample> {
  int radVal = 0;

  late TeXViewRenderingEngine renderingEngine;

  @override
  Widget build(BuildContext context) {
    renderingEngine = radVal == 0
        ? const TeXViewRenderingEngine.katex()
        : const TeXViewRenderingEngine.mathjax();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flutter TeX (Demo)"),
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
          RadioListTile<int>(
            value: 0,
            groupValue: radVal,
            onChanged: (val) {
              setState(() {
                radVal = val!;
              });
            },
            title: const Text("Katex"),
            subtitle: const Text("RenderingEngine for Fast Rendering"),
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: radVal,
            onChanged: (val) {
              setState(() {
                radVal = val!;
              });
            },
            title: const Text("MathJax"),
            subtitle: const Text("RenderingEngine for Quality Rendering"),
          ),
          const Divider(
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
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class _TeXViewMiniExampleState extends State<TeXViewMiniExample> {
  @override
  Widget build(BuildContext context) {
    return TeXView(
        child: const TeXViewColumn(children: [
          TeXViewInkWell(
            id: "id_0",
            child: TeXViewColumn(children: [
              TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
                  style: TeXViewStyle(textAlign: TeXViewTextAlign.center)),
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
        style: const TeXViewStyle(
          elevation: 10,
          borderRadius: TeXViewBorderRadius.all(25),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderColor: Colors.blue,
              borderStyle: TeXViewBorderStyle.solid,
              borderWidth: 5)),
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
            ));
  }
}
