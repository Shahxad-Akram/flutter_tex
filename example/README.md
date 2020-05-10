# flutter_tex_example
```dart

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  runApp(FlutterTeXExample());
}

TeXViewContainer _customTeXViewChild(String id, String title, String body) {
  return TeXViewContainer(
      id: id,
      style: TeXViewStyle(
        margin: TeXViewMargin.all(10),
        borderRadius: TeXViewBorderRadius.all(25),
        backgroundColor: Colors.green,
        contentColor: Colors.white,
      ),
      children: [
        TeXViewTeX(title,
            style: TeXViewStyle(
              padding: TeXViewPadding.only(top: 5, bottom: 5),
              textAlign: TeXViewTextAlign.Center,
              backgroundColor: Colors.red,
              contentColor: Colors.white,
            )),
        TeXViewTeX(body,
            style: TeXViewStyle.fromCSS(
                "color:white;background-color:light-green;padding:10px"))
      ]);
}

class FlutterTeXExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          getRenderEngineButton(
              context,
              "Katex",
              'assets/katex.png',
              "RenderingEngine for Fast Rendering",
              TeXViewRenderingEngine.katex(configurations: r"""
                  {
                    displayMode: true,
                    macros: {
                      "\\RR": "\\mathbb{R}"
                    }
                  }
                  """), [
            TeXExamples.introduction,
            TeXExamples.quadraticEquation,
            TeXExamples.relationEnergyPrincipalQuantum,
            TeXExamples.bohrRadius,
            TeXExamples.chemistryEquations,
            TeXExamples.matrix,
          ]),
          getRenderEngineButton(
              context,
              "MathJax",
              'assets/mathjax.png',
              "RenderingEngine for Quality Rendering",
              TeXViewRenderingEngine.mathjax(), [
            TeXExamples.introduction,
            TeXExamples.quadraticEquation,
            TeXExamples.relationEnergyPrincipalQuantum,
            TeXExamples.alignTag,
            TeXExamples.bohrRadius,
            TeXExamples.chemistryEquations,
            TeXExamples.matrix,
            TeXExamples.others,
          ]),
        ],
      ),
    );
  }

  getRenderEngineButton(
      BuildContext context,
      String label,
      String asset,
      String text,
      TeXViewRenderingEngine renderingEngine,
      List<TeXViewContainer> teXViewChildren) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
        elevation: 7.5,
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeXViewPage(
                        label: label,
                        teXViewChildren: teXViewChildren,
                        renderingEngine: renderingEngine,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Ink.image(
                image: AssetImage(asset),
                height: 75,
                fit: BoxFit.contain,
              ),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestExample extends StatelessWidget {
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

class TeXExamples {
  static TeXViewContainer introduction = TeXViewContainer(
      style: TeXViewStyle(
          margin: TeXViewMargin.all(10),
          padding: TeXViewPadding.all(10),
          borderRadius: TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderWidth: 10,
              borderStyle: TeXViewBorderStyle.Solid,
              borderColor: Colors.green))),
      children: [
        TeXViewTeX(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
            style: TeXViewStyle(
                borderRadius: TeXViewBorderRadius.only(
                    bottomRight: 20, bottomLeft: 20, topLeft: 10, topRight: 10),
                textAlign: TeXViewTextAlign.Center,
                width: 200,
                margin: TeXViewMargin.zeroAuto(),
                backgroundColor: Colors.green),
            id: "title_0"),
        TeXViewTeX(r"""      
      <p>Flutter \( \rm\\TeX \) is a Flutter Package to render so many types of equations based on \( \rm\\LaTeX \), It also includes full HTML with JavaScript
      support.</p>
      """, id: "body_0")
      ]);

  static TeXViewContainer quadraticEquation =
      _customTeXViewChild("child_1", r"<h3>Quadratic Equation</h3>", r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

  static TeXViewContainer bohrRadius = _customTeXViewChild(
      "child_2",
      r"<h3>Bohr's Radius</h3>",
      r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""");

  static TeXViewContainer relationEnergyPrincipalQuantum = _customTeXViewChild(
      "child_3",
      r"<h3>Relationship between Energy and Principal Quantum Number</h3>",
      r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

  static TeXViewContainer chemistryEquations = _customTeXViewChild(
      "child_4", r"<h3>Chemistry Equations</h3>", r"""<p>    
      
     \( \ce{CO2 + C -> 2 CO} \) <br>
     
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \) <br>
     
     Scroll long formulas in Katex $$ \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O} $$ <br>
     
    </p>""");

  static TeXViewContainer matrix =
      _customTeXViewChild("child_5", r"<h3>Matrix</h3>", r"""  <p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

  static TeXViewContainer alignTag =
      _customTeXViewChild("child_6", r"<h3>Align Tag</h3>", r"""    
           $$
           \begin{align}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{align}
           $$
    </p>""");

  static TeXViewContainer others =
      _customTeXViewChild("child_7", r"<h3> Others </h3>", r"""<p>    
    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
     $$ y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
              n  \\
              k  \\
            \end{array}} \right)p^k q^{n - k} $$
    </p>""");
}

class TeXViewPage extends StatefulWidget {
  final List<TeXViewContainer> teXViewChildren;
  final String label;
  final TeXViewRenderingEngine renderingEngine;

  TeXViewPage({this.label, this.teXViewChildren, this.renderingEngine});

  @override
  _TeXViewPageState createState() => _TeXViewPageState();
}

class _TeXViewPageState extends State<TeXViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Rendering with ${widget.label} Example"),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            "Rendered TeX HTML with ${widget.label}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          TeXView(
              showLoadingWidget: false,
              renderingEngine: widget.renderingEngine,
              children: widget.teXViewChildren,
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                elevation: 10,
                borderRadius: TeXViewBorderRadius.all(25),
                border: TeXViewBorder.all(TeXViewBorderDecoration(
                    borderColor: Colors.blue,
                    borderStyle: TeXViewBorderStyle.Solid,
                    borderWidth: 5)),
                backgroundColor: Colors.white,
              ),
              loadingWidget: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering with ${widget.label}")
                  ],
                ),
              ),
              onTap: (childID) {
                print("TeXView $childID is tapped.");
              }),
        ],
      ),
    );
  }
}

```



# Demo app is available on Google Play.
<a href='https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

[Example Source](https://github.com/shah-xad/flutter_tex/tree/master/example)
