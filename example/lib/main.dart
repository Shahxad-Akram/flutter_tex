import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  runApp(FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class TeXViewPage extends StatefulWidget {
  final List<TeXViewWidget> teXViewChildren;
  final String title;
  final TeXViewRenderingEngine renderingEngine;

  TeXViewPage({this.title, this.teXViewChildren, this.renderingEngine});

  @override
  _TeXViewPageState createState() => _TeXViewPageState();
}

class _MainPageState extends State<MainPage> {
  static TeXViewWidget introduction = TeXViewColumn(
      style: TeXViewStyle(
          margin: TeXViewMargin.all(10),
          padding: TeXViewPadding.all(10),
          borderRadius: TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderWidth: 10,
              borderStyle: TeXViewBorderStyle.Solid,
              borderColor: Colors.green))),
      children: [
        TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
            style: TeXViewStyle(
                borderRadius: TeXViewBorderRadius.only(
                    bottomRight: 20, bottomLeft: 20, topLeft: 10, topRight: 10),
                textAlign: TeXViewTextAlign.Center,
                width: 200,
                margin: TeXViewMargin.zeroAuto(),
                backgroundColor: Colors.green)),
        TeXViewDocument(r"""   
      <p>Flutter \( \rm\\TeX \) is a Flutter Package to render so many types of equations based on \( \rm\\LaTeX \), It also includes full HTML with JavaScript
      support.</p>
      """)
      ]);

  static TeXViewWidget quadraticEquation =
      _customTeXViewChild(r"<h3>Quadratic Equation</h3>", r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

  static TeXViewWidget bohrRadius = _customTeXViewChild(
      r"<h3>Bohr's Radius</h3>",
      r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""");

  static TeXViewWidget relationEnergyPrincipalQuantum = _customTeXViewChild(
      r"<h3>Relationship between Energy and Principal Quantum Number</h3>",
      r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

  static TeXViewWidget chemistryEquations =
      _customTeXViewChild(r"<h3>Chemistry Equations</h3>", r"""<p>    
      
     \( \ce{CO2 + C -> 2 CO} \) <br>
     
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \) <br>
     
     Scroll long formulas in Katex $$ \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O} $$ <br>
     
    </p>""");

  static TeXViewWidget matrix =
      _customTeXViewChild(r"<h3>Matrix</h3>", r"""  <p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

  static TeXViewWidget alignedTag =
      _customTeXViewChild(r"<h3>Aligned Tag</h3>", r"""    
           $$
           \begin{aligned}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{aligned}
           $$""");

  static TeXViewWidget others =
      _customTeXViewChild(r"<h3> Others </h3>", r"""<p>    
    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
    
     $$
     y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
              n  \\
              k  \\
            \end{array}} \right)p^k q^{n - k} 
     $$
    </p>""");

  List<TeXViewWidget> quizExample = [
    TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \) Statement</h2>""",
        style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
    TeXViewGroup(
        children: [
          TeXViewGroupItem(
            id: "item_1",
            child: TeXViewDocument(r"""<h3>Flutter \( \rm\\TeX \) 1</h3>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
          ),
          TeXViewGroupItem(
            id: "item_2",
            child: TeXViewDocument(r"""<h3>Flutter \( \rm\\TeX \) 2</h3>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
          ),
          TeXViewGroupItem(
            id: "item_3",
            child: TeXViewDocument(r"""<h3>Flutter \( \rm\\TeX \) 3</h3>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
          ),
          TeXViewGroupItem(
            id: "item_4",
            child: TeXViewDocument(r"""<h3>Flutter \( \rm\\TeX \) 4</h3>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
          ),
        ],
        selectedItemStyle: TeXViewStyle(
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 3, borderColor: Colors.blue)),
            margin: TeXViewMargin.all(5)),
        normalItemStyle: TeXViewStyle(margin: TeXViewMargin.all(5)))
  ];

  int radVal = 0;

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
          getExampleButton("Simple Examples", [
            introduction,
            quadraticEquation,
            relationEnergyPrincipalQuantum,
            alignedTag,
            bohrRadius,
            chemistryEquations,
            matrix,
            if (radVal == 1) ...[others]
          ]),
          getExampleButton("Quiz Example", quizExample),
          getExampleButton("Image Example", [
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
          ]),
          getExampleButton("Tap callback Example", [
            TeXViewInkWell(
              id: "this_item_is_clicked",
              child: TeXViewDocument(r"""<h2>Click \( \rm\\Here \)</h2>""",
                  style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
            )
          ]),
        ],
      ),
    );
  }

  getExampleButton(String title, List<TeXViewWidget> teXViewChildren) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        elevation: 7.5,
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeXViewPage(
                        teXViewChildren: teXViewChildren,
                        title: title,
                        renderingEngine: radVal == 0
                            ? TeXViewRenderingEngine.katex(configurations: r"""
                  {
                    displayMode: true,
                    macros: {
                      "\\RR": "\\mathbb{R}"
                    }
                  }
                  """)
                            : TeXViewRenderingEngine.mathjax(),
                      )));
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

  static TeXViewWidget _customTeXViewChild(String title, String body) {
    return TeXViewColumn(
        style: TeXViewStyle(
          margin: TeXViewMargin.all(10),
          borderRadius: TeXViewBorderRadius.all(25),
          backgroundColor: Colors.green,
          contentColor: Colors.white,
        ),
        children: [
          TeXViewDocument(title,
              style: TeXViewStyle(
                padding: TeXViewPadding.only(top: 5, bottom: 5),
                textAlign: TeXViewTextAlign.Center,
                backgroundColor: Colors.red,
                contentColor: Colors.white,
              )),
          TeXViewDocument(body,
              style: TeXViewStyle.fromCSS(
                  "color:white;background-color:light-green;padding:10px"))
        ]);
  }
}

class _TeXViewPageState extends State<TeXViewPage> {
  String onTapMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          Text(
            onTapMessage ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          TeXView(
              showLoadingWidget: true,
              renderingEngine: widget.renderingEngine,
              children: [...widget.teXViewChildren],
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
              ),
              onTap: (childID) {
                setState(() {
                  this.onTapMessage = "TeXView $childID is tapped.";
                });
              }),
        ],
      ),
    );
  }

  TeXView teXView() {
    return TeXView(
        showLoadingWidget: true,
        renderingEngine: widget.renderingEngine,
        children: [
          TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
              style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
          TeXViewInkWell(
            id: "id_0",
            child: TeXViewColumn(children: [
              TeXViewContainer(
                child: TeXViewImage.network(
                    'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
                style: TeXViewStyle(
                  margin: TeXViewMargin.all(10),
                  borderRadius: TeXViewBorderRadius.all(20),
                ),
              ),
            ]),
          ),
          TeXViewGroup(
              children: [
                TeXViewGroupItem(
                  id: "item_1",
                  child: TeXViewDocument(
                      r"""<h2>Flutter \( \rm\\TeX \) 1</h2>""",
                      style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
                ),
                TeXViewGroupItem(
                  id: "item_2",
                  child: TeXViewDocument(
                      r"""<h2>Flutter \( \rm\\TeX \) 2</h2>""",
                      style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
                ),
                TeXViewGroupItem(
                  id: "item_3",
                  child: TeXViewDocument(
                      r"""<h2>Flutter \( \rm\\TeX \) 3</h2>""",
                      style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
                ),
                TeXViewGroupItem(
                  id: "item_4",
                  child: TeXViewDocument(
                      r"""<h2>Flutter \( \rm\\TeX \) 4</h2>""",
                      style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
                ),
              ],
              selectedItemStyle: TeXViewStyle(
                  border: TeXViewBorder.all(TeXViewBorderDecoration(
                      borderWidth: 5, borderColor: Colors.blue)),
                  margin: TeXViewMargin.all(5)),
              normalItemStyle: TeXViewStyle(margin: TeXViewMargin.all(5)))
        ],
        style: TeXViewStyle(
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
              Text("Rendering...")
            ],
          ),
        ),
        onTap: (childID) {
          print("TeXView $childID is tapped.");
        });
  }
}
