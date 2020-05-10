import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class FlutterTeXExampleMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: TeXView(
            renderingEngine: TeXViewRenderingEngine.katex(),
            children: [
              TeXViewContainer(id: "container_0", children: [
                TeXViewTeX(
                  r"<h3>Quadratic Equation</h3>",
                  style: TeXViewStyle(
                    textAlign: TeXViewTextAlign.Center,
                    backgroundColor: Colors.red,
                    contentColor: Colors.white,
                  ),
                  id: "tex_0",
                ),
                TeXViewTeX(r"""<p>                                
                           When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                           $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                    style: TeXViewStyle.fromCSS(
                        "color:white;background-color:green;padding:20px"),
                    id: "tex_1"),
              ])
            ],
            style: TeXViewStyle(
              margin: TeXViewMargin.all(20),
              elevation: 10,
              borderRadius: TeXViewBorderRadius.all(20),
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
                  Text("Rendering with ")
                ],
              ),
            ),
            onTap: (childID) {
              print("TeXView $childID is tapped.");
            }),
      ),
    );
  }
}
