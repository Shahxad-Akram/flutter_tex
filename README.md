# Flutter TeX

A Flutter Package to render **Mathematics, Physics** and **Chemistry Equations** based on **LaTeX** with full **HTML** support using [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) plugin.

This is based on [mini-mathjax](https://github.com/electricbookworks/mini-mathjax) a simplified version of [MathJax](https://github.com/mathjax/MathJax/) a JavaScript library.

**Only Tested on Android not on iOS because I don't own a Mac.**

## Use this package as a library

**1:** Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_tex: ^0.0.18
```

**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

**3:** Now in your Dart code, you can use:

```dart
import 'package:flutter_tex/flutter_tex.dart';
```**4:** Make sure to add this line in your AndroidManifest.xml under `application` like this.
```xml
<application
       android:usesCleartextTraffic="true">
</application>
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
runApp(FlutterTeX());
}

class FlutterTeX extends StatefulWidget {
@override
_FlutterTeXState createState() => _FlutterTeXState();
}

class _FlutterTeXState extends State<FlutterTeX> {
  String teX = Uri.encodeComponent(r"""
  <p>
    A simple Example to render \( \rm\\TeX \) in flutter<br>

    <style>
      .card {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        transition: 0.3s;
        width: 40%;
      }

      .card:hover {
        box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
      }

      .container {
        padding: 2px 16px;
      }
    </style>
    <div class="card">
      <div class="container">
        <p>
          \begin{align}
          \dot{x} & = \sigma(y-x) \\
          \dot{y} & = \rho x - y - xz \\
          \dot{z} & = -\beta z + xy
          \end{align}
        </p>
      </div>
    </div>

    <br>
    <br>

    When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are

    $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>

    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>

    Bohr Radius

    \( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)<br>

    Relationship between Energy and Principal Quantum Number

    \( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)<br><br>

    $$\ce{CO2 + C -> 2 CO}$$ <br><br>

    $$\ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-}$$ <br><br>

    $$\ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O}$$ <br><br>

  </p>
  """);

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Flutter TeX Example"),
       ),
       body: TeXView(
         teXHTML: teX,
       ),
     ),
   );
 }
}
```

# Screenshots

<img height="800" src="https://github.com/shahzadakram67/flutter_tex/blob/master/screenshots/Screenshot_1.png" alt="FlutterTeXMaths">

<img height="800" src="https://github.com/shahzadakram67/flutter_tex/blob/master/screenshots/Screenshot_2.png" alt="FlutterTeXMaths">

[![Tweet Flutter_TeX](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=A%20Flutter%20Package%20to%20render%20Mathematics%2C%20Physics%20and%20Chemistry%20Equations%20based%20on%20LaTeX%20with%20full%20HTML%20support.&url=https://github.com/shahzadakram67/flutter_tex&via=shahzadakram67&hashtags=flutter,flutter_tex,latex,equations)

