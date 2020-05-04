import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  runApp(FlutterTeXExample());
}

TeXViewChild _customTeXViewChild(String id, String title, String body) {
  return TeXViewChild(
      id: id,
      title: title,
      body: body,
      decoration: TeXViewDecoration(
          style: TeXViewStyle(
            margin: TeXViewMargin(all: 10),
            borderRadius: TeXViewBorderRadius(all: 20),
            backgroundColor: Colors.green,
            contentColor: Colors.white,
          ),
          titleStyle: TeXViewStyle(
            padding: TeXViewPadding(top: 5, bottom: 5),
            textAlign: TeXViewTextAlign.Center,
            backgroundColor: Colors.red,
            contentColor: Colors.white,
          ),
          bodyStyle: TeXViewStyle.fromCSS(
              "color:white;background-color:light-green;padding:10px")));
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
          getRenderEngineButton(context, "Katex", 'assets/katex.png',
              "RenderingEngine for Fast Rendering", RenderingEngine.Katex, [
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
              RenderingEngine.MathJax, [
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
      RenderingEngine renderingEngine,
      List<TeXViewChild> teXViewChildren) {
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

class TeXExamples {
  static TeXViewChild introduction = TeXViewChild(
      id: "child_0",
      title: r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
      body: r"""      
      <p>Flutter \( \rm\\TeX \) is a Flutter Package to render so many types of equations based on \( \rm\\LaTeX \), It also includes full HTML with JavaScript
      support.</p>
      """,
      decoration: TeXViewDecoration(
          titleStyle: TeXViewStyle(textAlign: TeXViewTextAlign.Center),
          style: TeXViewStyle(
              margin: TeXViewMargin(all: 10),
              padding: TeXViewPadding(all: 10),
              borderRadius: TeXViewBorderRadius(all: 10),
              border: TeXViewBorder(
                  all: TeXViewBorderDecoration(
                      borderWidth: 10,
                      borderStyle: TeXViewBorderStyle.Solid,
                      borderColor: Colors.green)))));

  static TeXViewChild quadraticEquation =
      _customTeXViewChild("child_1", r"<h3>Quadratic Equation</h3>", r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

  static TeXViewChild bohrRadius = _customTeXViewChild(
      "child_2",
      r"<h3>Bohr's Radius</h3>",
      r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""");

  static TeXViewChild relationEnergyPrincipalQuantum = _customTeXViewChild(
      "child_3",
      r"<h3>Relationship between Energy and Principal Quantum Number</h3>",
      r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

  static TeXViewChild chemistryEquations = _customTeXViewChild(
      "child_4", r"<h3>Chemistry Equations</h3>", r"""<p>    
      
     \( \ce{CO2 + C -> 2 CO} \) <br>
     
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \) <br>
     
     Scroll long formulas in Katex $$ \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O} $$ <br>
     
    </p>""");

  static TeXViewChild matrix =
      _customTeXViewChild("child_5", r"<h3>Matrix</h3>", r"""  <p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

  static TeXViewChild alignTag =
      _customTeXViewChild("child_6", r"<h3>Align Tag</h3>", r"""    
           $$
           \begin{align}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{align}
           $$
    </p>""");

  static TeXViewChild others =
      _customTeXViewChild("child_7", r"<h3> Others </h3>", r"""<p>    
 
    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
 
     $$ y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
              n  \\
              k  \\
            \end{array}} \right)p^k q^{n - k} $$
 
    </p>""");
}

class TeXViewPage extends StatefulWidget {
  List<TeXViewChild> teXViewChildren;
  final String label;
  final RenderingEngine renderingEngine;

  TeXViewPage({this.label, this.teXViewChildren, this.renderingEngine});

  @override
  _TeXViewPageState createState() => _TeXViewPageState();
}

class _TeXViewPageState extends State<TeXViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          widget.teXViewChildren.removeAt(0);
        });
      }),*/
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
          Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TeXView(
                    showLoadingWidget: false,
                    renderingEngine: widget.renderingEngine,
                    children: widget.teXViewChildren,
                    style: TeXViewStyle(
                      margin: TeXViewMargin(all: 15),
                      elevation: 10,
                      borderRadius: TeXViewBorderRadius(all: 25),
                      border: TeXViewBorder(
                          all: TeXViewBorderDecoration(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
