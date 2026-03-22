[![GitHub stars](https://img.shields.io/github/stars/Shahxad-Akram/flutter_tex?style=social)](https://github.com/Shahxad-Akram/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

<div align="middle">
  <img src="https://raw.githubusercontent.com/Shahxad-Akram/flutter_tex/refs/heads/main/example/assets/flutter_tex_banner.png" height="250px"/>
</div>
<br>

<div align="middle">

![Schrödinger Equation](https://latex.codecogs.com/svg.image?\Huge&space;i\hbar&space;\frac{\partial}{\partial&space;t}&space;\Psi(\mathbf{r},t)&space;=&space;\left[&space;-\frac{\hbar^2}{2m}&space;\nabla^2&space;+&space;V(\mathbf{r},t)&space;\right]&space;\Psi(\mathbf{r},t))

</div>

Flutter TeX is a self-contained Flutter package leveraging [MathJax](https://github.com/mathjax/MathJax) to deliver robust, fully offline rendering of mathematical and chemical notations.
---

## 🚀 Key Features

* **Offline Rendering**: No internet connection required after setup.
* **Multiple Formats**: Supports LaTeX, TeX, MathML, and AsciiMath.
* **Three Powerful Widgets**:
  - [Math2SVG](https://flutter-tex.readthedocs.io/en/latest/math-2-svg/): Pure Flutter based (no webview) high-performance widget, for maths formulas rendering, support LaTeX, MathML and AsciiMath.
  - [TeXWidget](https://flutter-tex.readthedocs.io/en/latest/tex-widget/): Based on `Math2SVG` dedicated for LaTeX rendering.
  - [TeXView](https://flutter-tex.readthedocs.io/en/latest/tex-view/): Advanced webview-based rendering for complex HTML/JS content.
* 👉 [Click Here for Full Documentation](https://flutter-tex.readthedocs.io/en/latest/)

<br>
<table>
  <tr>
    <td align="center">
      <a href="https://flutter-tex.web.app" target="_blank">
        <img src="https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png" width="75%" alt="Flutter Web">
      </a>
      <h3>Web Demo</h3>
    </td>
    <td align="center">
      <a href="https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example" target="_blank">
        <img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" width="75%" alt="Get it on Google Play"/>
      </a>
      <h3>Android Demo</h3>
    </td>
    <td align="center">
      <a href="https://www.youtube.com/watch?v=YiNbVEXV_NM" target="_blank">
         <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/YouTube_2024.svg/960px-YouTube_2024.svg.png" width="75%" alt="YouTube Demo"/>
      </a>
      <h3>Video Demo (old)</h3>
    </td>
  </tr>
</table>


See screenshots in the [Gallery](https://flutter-tex.readthedocs.io/en/latest/gallery/).

## 📦 Installation

For the detailed installation and setup instructions for different platforms , please refer to the [Installation Guide](https://flutter-tex.readthedocs.io/en/latest/installation/).

## 🛠 Quick Example

> [!CAUTION]
Make sure to follow the [Installation Guide](https://flutter-tex.readthedocs.io/en/latest/installation/) before running the example.

```dart
Math2SVG(math: r"x = {-b \pm \sqrt{b^2-4ac} \over 2a}")
```
Output:

![Quadratic Formula](https://latex.codecogs.com/svg.image?\Huge&space;x&space;=&space;\frac{-b&space;\pm&space;\sqrt{b^2-4ac}}{2a})


👉 [See Detailed Examples](https://github.com/Shahxad-Akram/flutter_tex/tree/main/example)

## 📖 Full Documentation

For detailed setup instructions, API references, and advanced configurations (Custom Fonts, MathJax settings, etc.), please visit our official documentation:

<p align="center">
  <a href="https://flutter-tex.readthedocs.io">
    <img src="https://img.shields.io/badge/READ_THE_DOCS-PASSING?style=for-the-badge&logo=readthedocs&logoColor=white&color=blueviolet" width="300">
  </a>
</p>

## Credits
We extend our sincere credit to the original [MathJax](https://github.com/mathjax/MathJax) developers, whose work is the foundation of this package.

