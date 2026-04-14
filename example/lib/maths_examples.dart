/// This file contains strings for various mathematical examples used in the application.
///
/// It includes TeX, MathML, and AsciiMath examples covering topics from Physics,
/// Mathematics, and Chemistry.
library;

final String teXWidgetContent =
    r"""Flutter $ \rm\TeX $ is a Flutter Package to render so many types of equations based on \( \rm\LaTeX \), It also includes full HTML with JavaScript support. Here's a simple example of $ \rm\TeX $ rendering:
          
      When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$ Another display formula is: \[ E = mc^2 + \frac{p^2}{2m} + \sum_{i} \frac{(p_i - qA_i)^2}{2m_i} + V(r) + ... \]""";

const Map<String, String> laTeXExamples = {
  "Schrödinger":
      r"i\hbar\frac{\partial}{\partial t}\Psi(\mathbf{r},t) = \left [ -\frac{\hbar^2}{2m}\nabla^2 + V(\mathbf{r},t)\right ]\Psi(\mathbf{r},t)",
  "Quadratic": r"x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}",
  "Gaussian": r"\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}",
  "Matrix": r"\begin{bmatrix} a & b \\ c & d \end{bmatrix}",
  "Maxwell's Equations":
      r"\begin{aligned} \nabla \cdot \mathbf{E} &= \frac{\rho}{\epsilon_0} \\ \nabla \cdot \mathbf{B} &= 0 \\ \nabla \times \mathbf{E} &= -\frac{\partial \mathbf{B}}{\partial t} \\ \nabla \times \mathbf{B} &= \mu_0\left(\mathbf{J} + \epsilon_0 \frac{\partial \mathbf{E}}{\partial t}\right) \end{aligned}",
  "Riemann Zeta":
      r"\zeta(s) = \sum_{n=1}^{\infty} \frac{1}{n^s} = \prod_{p \text{ prime}} \frac{1}{1-p^{-s}}",
  "Navier-Stokes":
      r"\rho \left( \frac{\partial \mathbf{u}}{\partial t} + \mathbf{u} \cdot \nabla \mathbf{u} \right) = -\nabla p + \mu \nabla^2 \mathbf{u} + \mathbf{f}",
  "Einstein Field":
      r"G_{\mu\nu} + \Lambda g_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu}",
  "Fourier Transform":
      r"\hat{f}(\xi) = \int_{-\infty}^{\infty} f(x) e^{-2\pi i x \xi} \, dx",
  "Black-Scholes":
      r"\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + rS \frac{\partial V}{\partial S} - rV = 0",
  "Chemical Equation": r"\ce{CO2 + C -> 2 CO}"
};

const Map<String, String> mathMLExamples = {
  "Relativity": r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <msup><mi>E</mi><mn>2</mn></msup>
      <mo>=</mo>
      <msup><mrow><mfenced><mrow><mi>m</mi><msup><mi>c</mi><mn>2</mn></msup></mfenced></mrow><mn>2</mn></msup>
      <mo>+</mo>
      <msup><mrow><mfenced><mrow><mi>p</mi><mi>c</mi></mrow></mfenced></mrow><mn>2</mn></msup>
    </math>""",
  "Fraction": r"<math><mfrac><mn>1</mn><mn>2</mn></mfrac></math>",
  "Quadratic":
      r"""<math xmlns="http://www.w3.org/1998/Math/MathML"><mrow><mrow><msup><mi>x</mi><mn>2</mn></msup><mo>+</mo><mrow><mn>4</mn><mo>⁢</mo><mi>x</mi></mrow><mo>+</mo><mn>4</mn></mrow><mo>=</mo><mn>0</mn></mrow></math>""",
  "Gaussian Integral": r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <msubsup><mo>∫</mo><mrow><mo>-</mo><mo>∞</mo></mrow><mo>∞</mo></msubsup>
      <msup><mi>e</mi><mrow><mo>-</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></msup>
      <mi>d</mi><mi>x</mi>
      <mo>=</mo>
      <msqrt><mi>π</mi></msqrt>
    </math>""",
  "Identity Matrix": r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi>I</mi><mo>=</mo>
      <mfenced open="[" close="]"><mtable>
        <mtr><mtd><mn>1</mn></mtd><mtd><mn>0</mn></mtd></mtr>
        <mtr><mtd><mn>0</mn></mtd><mtd><mn>1</mn></mtd></mtr>
      </mtable></mfenced>
    </math>""",
  "Golden Ratio": r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi>φ</mi><mo>=</mo><mn>1</mn><mo>+</mo>
      <mfrac><mn>1</mn><mrow>
        <mn>1</mn><mo>+</mo><mfrac><mn>1</mn><mrow>
          <mn>1</mn><mo>+</mo><mfrac><mn>1</mn><mrow><mn>1</mn><mo>+</mo><mo>&#x2026;</mo></mrow></mfrac>
        </mrow></mfrac>
      </mrow></mfrac>
    </math>""",
  "Gauss Magnetism": r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mo>∇</mo><mo>⋅</mo><mi mathvariant="bold">B</mi><mo>=</mo><mn>0</mn>
    </math>"""
};

const Map<String, String> asciiMathExamples = {
  "Quadratic": r"x = (-b +- sqrt(b^2 - 4ac))/(2a)",
  "Summation": r"sum_(i=1)^n i^3=((n(n+1))/2)^2",
  "Cauchy-Schwarz":
      r"| sum_(i=1)^n a_i b_i |^2 <= (sum_(i=1)^n a_i^2)(sum_(i=1)^n b_i^2)",
  "Standard Deviation": r"sigma = sqrt(1/N sum_(i=1)^N (x_i - mu)^2)",
  "Matrix Product": r"[[a,b],[c,d]] ((x),(y)) = ((ax+by),(cx+dy))",
  "Taylor Series":
      r"e^x = sum_(n=0)^oo (x^n)/(n!) = 1 + x + x^2/(2!) + x^3/(3!) + ...",
  "Limit Definition": r"f'(x) = lim_(h->0) (f(x+h) - f(x))/h",
  "Cauchy Integral": r"f(a) = 1/(2 pi i) oint_gamma (f(z))/(z-a) dz"
};
