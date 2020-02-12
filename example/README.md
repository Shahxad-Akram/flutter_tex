# flutter_tex_example
```dart
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

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter TeX Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeXViewPage(
                              label: "Katex",
                              textEditingController:
                                  new TextEditingController(text: katexTeXHTML),
                              renderingEngine: RenderingEngine.Katex,
                            )));
              },
              child: Text("Katex Example\nFast Rendering"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeXViewPage(
                              label: "MathJax",
                              textEditingController: new TextEditingController(
                                  text: mathJaxTeXHTML),
                              renderingEngine: RenderingEngine.MathJax,
                            )));
              },
              child: Text("MathJax Example\nQuality Rendering"),
            )
          ],
        ),
      ),
    );
  }
}

class TeXViewPage extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final RenderingEngine renderingEngine;

  TeXViewPage({this.label, this.textEditingController, this.renderingEngine});

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
          Container(
            margin: EdgeInsets.all(10),
            child: Material(
              shape: RoundedRectangleBorder(side: BorderSide()),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "${widget.label} TeX HTML input"),
                  controller: widget.textEditingController,
                  maxLines: 15,
                  onChanged: (string) {
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Divider(
            height: 10,
          ),
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
                  renderingEngine: widget.renderingEngine,
                  teXHTML: widget.textEditingController.text,
                  loadingWidget: Center(
                    child: Text("Rendering with ${widget.label}"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String mathJaxTeXHTML = r"""
   <p>
     A simple Example to render \( \rm\\TeX \) in flutter with full <B>HTML</B> support<br>
           $$
           \begin{align}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{align}
           $$
     <br>
 
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
 
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>
 
 
     $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
 
 
     $$ y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
   n  \\
   k  \\
\end{array}} \right)p^k q^{n - k} $$
 
     Bohr Radius
 
     \( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)<br>
 
     Relationship between Energy and Principal Quantum Number
 
     \( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)<br><br>
  
     <br><br>
   </p>

    Inline Chemistry Equations <br>
         <p>    
     \( \ce{CO2 + C -> 2 CO} \) <br>
  
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \) <br>
 
     \( \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O} \) <br>
  
    </p>

   """;

String katexTeXHTML = r"""
   <p>
     A simple Example to render \( \rm\\TeX \) in flutter with full <B>HTML</B> support<br><br>
 
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
 
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>
 
 
     Bohr Radius
 
     \( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)<br>
 
     Relationship between Energy and Principal Quantum Number
 
     \( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)<br><br>
  
     <br><br>
   </p>

    Inline Chemistry Equations <br>
         <p>    
     \({CO2 + C -> 2 CO}\) <br>
  
     \({Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-}\) <br>
 
     \({x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O}\) <br>
  
    </p>

   """;

```



[Complete working application Example](https://github.com/shahxadakram/flutter_tex/tree/master/example)
