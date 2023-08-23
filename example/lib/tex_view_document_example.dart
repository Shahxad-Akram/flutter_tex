import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeXExample {
  static TeXViewWidget introduction =
      _teXViewWidget(r"""<h4>Flutter \( \rm\TeX \)</h4>""", r""" 
             
      <html><head></head><body><p><math xmlns=\"http://www.w3.org/1998/Math/MathML\"><mi>S</mi><mi>i</mi><mi>m</mi><mi>o</mi><mi>n</mi><mo>&nbsp;</mo><mi>w</mi><mi>o</mi><mi>n</mi><mo>&nbsp;</mo><mo>$</mo><mn>50</mn><mo>,</mo><mn>000</mn><mo>&nbsp;</mo><mi>o</mi><mi>n</mi><mo>&nbsp;</mo><mi>a</mi><mo>&nbsp;</mo><mi>s</mi><mi>c</mi><mi>r</mi><mi>a</mi><mi>t</mi><mi>c</mi><mi>h</mi><mo>-</mo><mi>o</mi><mi>f</mi><mi>f</mi><mo>&nbsp;</mo><mi>t</mi><mi>i</mi><mi>c</mi><mi>k</mi><mi>e</mi><mi>t</mi><mo>.</mo><mo>&nbsp;</mo><mo>&nbsp;</mo><mi>A</mi><mi>f</mi><mi>t</mi><mi>e</mi><mi>r</mi><mo>&nbsp;</mo><mi>p</mi><mi>a</mi><mi>y</mi><mi>i</mi><mi>n</mi><mi>g</mi><mo>&nbsp;</mo><mn>30</mn><mo>%</mo><mo>&nbsp;</mo><mi>i</mi><mi>n</mi><mo>&nbsp;</mo><mi>t</mi><mi>a</mi><mi>x</mi><mi>e</mi><mi>s</mi><mo>,</mo><mo>&nbsp;</mo><mi>h</mi><mi>e</mi><mo>&nbsp;</mo><mi>t</mi><mi>h</mi><mi>e</mi><mi>n</mi><mo>&nbsp;</mo><mi>p</mi><mi>a</mi><mi>i</mi><mi>d</mi><mo>&nbsp;</mo><mo>$</mo><mn>15</mn><mo>,</mo><mn>000</mn><mo>&nbsp;</mo><mi>f</mi><mi>o</mi><mi>r</mi><mo>&nbsp;</mo><mi>a</mi><mo>&nbsp;</mo><mi>n</mi><mi>e</mi><mi>w</mi><mo>&nbsp;</mo><mi>m</mi><mi>o</mi><mi>t</mi><mi>o</mi><mi>r</mi><mi>c</mi><mi>y</mi><mi>c</mi><mi>l</mi><mi>e</mi><mo>.</mo><mo>&nbsp;</mo><mo>&nbsp;</mo><mi>H</mi><mi>e</mi><mo>&nbsp;</mo><mi>t</mi><mi>o</mi><mi>o</mi><mi>k</mi><mo>&nbsp;</mo><mi>t</mi><mi>h</mi><mi>e</mi><mo>&nbsp;</mo><mi>r</mi><mi>e</mi><mi>m</mi><mi>a</mi><mi>i</mi><mi>n</mi><mi>i</mi><mi>n</mi><mi>g</mi><mo>&nbsp;</mo><mi>o</mi><mi>f</mi><mo>&nbsp;</mo><mi>h</mi><mi>i</mi><mi>s</mi><mo>&nbsp;</mo><mi>w</mi><mi>i</mi><mi>n</mi><mi>n</mi><mi>i</mi><mi>n</mi><mi>g</mi><mi>s</mi><mo>&nbsp;</mo><mi>a</mi><mi>n</mi><mi>d</mi><mo>&nbsp;</mo><mi>i</mi><mi>n</mi><mi>v</mi><mi>e</mi><mi>s</mi><mi>t</mi><mi>e</mi><mi>d</mi><mo>&nbsp;</mo><mi>i</mi><mi>n</mi><mo>&nbsp;</mo><mi>d</mi><mi>a</mi><mi>y</mi><mo>&nbsp;</mo><mi>t</mi><mi>r</mi><mi>a</mi><mi>d</mi><mi>i</mi><mi>n</mi><mi>g</mi><mo>,</mo><mo>&nbsp;</mo><mi>w</mi><mi>h</mi><mi>e</mi><mi>r</mi><mi>e</mi><mo>&nbsp;</mo><mi>h</mi><mi>e</mi><mo>&nbsp;</mo><mi>e</mi><mi>a</mi><mi>r</mi><mi>n</mi><mi>e</mi><mi>d</mi><mo>&nbsp;</mo><mn>20</mn><mo>%</mo><mo>&nbsp;</mo><mi>o</mi><mi>f</mi><mo>&nbsp;</mo><mi>h</mi><mi>i</mi><mi>s</mi><mo>&nbsp;</mo><mi>i</mi><mi>n</mi><mi>v</mi><mi>e</mi><mi>s</mi><mi>t</mi><mi>m</mi><mi>e</mi><mi>n</mi><mi>t</mi><mo>.</mo><mo>&nbsp;</mo><mo>&nbsp;</mo><mspace linebreak=\"newline\">&nbsp;</mspace><mi>H</mi><mi>o</mi><mi>w</mi><mo>&nbsp;</mo><mi>m</mi><mi>u</mi><mi>c</mi><mi>h</mi><mo>&nbsp;</mo><mi>m</mi><mi>o</mi><mi>n</mi><mi>e</mi><mi>y</mi><mo>&nbsp;</mo><mi>d</mi><mi>o</mi><mi>e</mi><mi>s</mi><mo>&nbsp;</mo><mi>S</mi><mi>i</mi><mi>m</mi><mi>o</mi><mi>n</mi><mo>&nbsp;</mo><mi>h</mi><mi>a</mi><mi>v</mi><mi>e</mi><mo>&nbsp;</mo><mi>a</mi><mi>f</mi><mi>t</mi><mi>e</mi><mi>r</mi><mo>&nbsp;</mo><mi>t</mi><mi>h</mi><mi>i</mi><mi>s</mi><mo>?</mo></math></p><figure class=\"image image_resized\" style=\"width:417px;\"><span class=\"archerSourceImage\"><img src=\"https://cdn-dev.archerreview.com/storage/question/images/43e4a0f0-a6e6-4f13-9191-1191951892ef.jpeg\"><a style=\"font-size: 12px;margin-bottom: 10px;color: rgba(170, 170, 170, 1);font-style: italic;display:block;\" target=\"_blank\" class=\"archerreview_anchor_tag\">Source : teliport</a></span></figure><ol><li>Pre-modeling.</li><li>Model Building.</li><li>Model Runs.</li><li>Experimentation.</li><li>Final Thoughts.</li></ol><ul><li>Pre-modeling.</li><li>Model Building.</li><li>Model Runs.</li><li>Experimentation.</li><li>Final Thoughts.</li></ul></body></html>
      """);

  static TeXViewWidget quadraticEquation =
      _teXViewWidget(r"<h4>Quadratic Equation</h4>", r"""
     <html><head></head><body><p>How long does a transmission last?</p><p>With proper maintenance, transmissions can last <strong>up to 300,000 miles or more</strong>. This includes changing the fluid in your transmission system and regular checkups. However, when you don't keep up with routine maintenance, your transmission might have problems at the 100,000-mile mark or even sooner.How long does a transmission last?With proper maintenance, transmissions can last <strong>up to 300,000 miles or more</strong>. This includes changing the fluid in your transmission system and regular checkups. However, when you don't keep up with routine maintenance, your transmission might have problems at the 100,000-mile mark or even sooner.</p><figure class=\"image image_resized\" style=\"width:18.19%;\"><span class=\"archerSourceImage\"><img src=\"https://cdn-dev.archerreview.com/storage/question/images/9344eaa2-5aad-4b78-ae9b-8d5ce4dae838.jpeg\"><a style=\"font-size: 12px;margin-bottom: 10px;color: rgba(170, 170, 170, 1);font-style: italic;display:block;\" target=\"_blank\" class=\"archerreview_anchor_tag\">Source : heater coill</a></span></figure></body></html>""");

  static TeXViewWidget mathML =
      _teXViewWidget(r"<h4>MathML (MathJax Only)</h4>", r"""
<math xmlns = "http://www.w3.org/1998/Math/MathML">
   <mrow>
      <mrow>
         <msup> <mi>x</mi> <mn>2</mn> </msup> <mo>+</mo>
         <mrow>
            <mn>4</mn>
            <mo>⁢</mo>
            <mi>x</mi>
         </mrow>
         <mo>+</mo>
         <mn>4</mn>
      </mrow>
      
      <mo>=</mo>
      <mn>0</mn>
   </mrow>
</math>""");

  static TeXViewWidget bohrRadius = _teXViewWidget(r"<h4>Bohr's Radius</h4>",
      r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""");

  static TeXViewWidget relationEnergyPrincipalQuantum = _teXViewWidget(
      r"<h4>Relationship between Energy and Principal Quantum Number</h4>",
      r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

  static TeXViewWidget chemistryEquations =
      _teXViewWidget(r"<h4>Chemistry Equations</h4>", r"""<p>    
     \( \ce{CO2 + C -> 2 CO} \) <br>
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \)<br>
     Scroll long formulas in Katex $$ \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x Nh4 ^ + x H2O} $$ <br>
    </p>""");

  static TeXViewWidget matrix = _teXViewWidget(r"<h4>Matrix</h4>", r"""<p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

  static TeXViewWidget alignedTag =
      _teXViewWidget(r"<h4>Aligned Tag</h4>", r"""    
           $$
           \begin{aligned}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{aligned}
           $$""");

  static TeXViewWidget others = _teXViewWidget(r"<h4> Others </h4>", r"""<p>    
    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
    
     $$
     y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
              n  \\
              k  \\
            \end{array}} \right)p^k q^{n - k} 
     $$

    </p>""");

  static TeXViewWidget _teXViewWidget(String title, String body) {
    return TeXViewColumn(
        style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                borderStyle: TeXViewBorderStyle.groove,
                borderColor: Colors.green))),
        children: [
          TeXViewDocument(
            title,
            style: const TeXViewStyle(
                padding: TeXViewPadding.all(10),
                borderRadius: TeXViewBorderRadius.all(10),
                textAlign: TeXViewTextAlign.center,
                width: 250,
                margin: TeXViewMargin.zeroAuto(),
                backgroundColor: Colors.green),
          ),
          TeXViewDocument(
            body,
            style: const TeXViewStyle(
              margin: TeXViewMargin.only(top: 10),
              padding: TeXViewPadding.only(left: 20),
            ),
          )
        ]);
  }
}

class TeXViewDocumentExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewDocumentExamples(
      {Key? key, this.renderingEngine = const TeXViewRenderingEngine.katex()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeXViewDocument"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TeXView(
              renderingEngine: renderingEngine,
              navigationDelegate: (NavigationRequest request) {
                // ignore: avoid_print
                print("Current URL : ${request.url}");
                return NavigationDecision.prevent;
              },
              onRenderStarted: () {
                // ignore: avoid_print
                print("Rendered successfully started the texView");
              },
              onRenderFinished: (height) {
                // ignore: avoid_print
                print("Rendered successfully finished the texView");
              },
              child: TeXExample.introduction,
              key: UniqueKey(),
            ),
            const SizedBox(height: 10),
            TeXView(
              renderingEngine: renderingEngine,
              navigationDelegate: (NavigationRequest request) {
                // ignore: avoid_print
                print("Current URL : ${request.url}");
                return NavigationDecision.prevent;
              },
              onRenderStarted: () {
                // ignore: avoid_print
                print("Rendered successfully started the texView");
              },
              onRenderFinished: (height) {
                // ignore: avoid_print
                print("Rendered successfully finished the texView");
              },
              child: TeXExample.quadraticEquation,
              key: UniqueKey(),
            ),
            const SizedBox(height: 10),
            TeXView(
              renderingEngine: renderingEngine,
              navigationDelegate: (NavigationRequest request) {
                // ignore: avoid_print
                print("Current URL : ${request.url}");
                return NavigationDecision.prevent;
              },
              onRenderStarted: () {
                // ignore: avoid_print
                print("Rendered successfully started the texView");
              },
              onRenderFinished: (height) {
                // ignore: avoid_print
                print("Rendered successfully finished the texView");
              },
              child: TeXExample.mathML,
              key: UniqueKey(),
            ),
            const SizedBox(height: 10),
            TeXView(
              renderingEngine: renderingEngine,
              navigationDelegate: (NavigationRequest request) {
                // ignore: avoid_print
                print("Current URL : ${request.url}");
                return NavigationDecision.prevent;
              },
              onRenderStarted: () {
                // ignore: avoid_print
                print("Rendered successfully started the texView");
              },
              onRenderFinished: (height) {
                // ignore: avoid_print
                print("Rendered successfully finished the texView");
              },
              child: TeXExample.relationEnergyPrincipalQuantum,
              key: UniqueKey(),
            ),
            const SizedBox(height: 10),
            TeXView(
              renderingEngine: renderingEngine,
              navigationDelegate: (NavigationRequest request) {
                // ignore: avoid_print
                print("Current URL : ${request.url}");
                return NavigationDecision.prevent;
              },
              onRenderStarted: () {
                // ignore: avoid_print
                print("Rendered successfully started the texView");
              },
              onRenderFinished: (height) {
                // ignore: avoid_print
                print("Rendered successfully finished the texView");
              },
              child: TeXExample.chemistryEquations,
              key: UniqueKey(),
            ),
          ],
        ),
      ),
    );
  }
}
