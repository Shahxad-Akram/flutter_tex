import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

InAppLocalhostServer localhostServer = new InAppLocalhostServer();

Future main() async {
  await localhostServer.start();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String teX = Uri.encodeComponent("""
  <p>
  A simple Example to render \\( \\rm\\TeX \\) in flutter<br>
  
  When \\(a \\ne 0 \\), there are two solutions to \\(ax^2 + bx + c = 0\\) and they are
\$\$x = {-b \\pm \\sqrt{b^2-4ac} \\over 2a}.\$\$<br>


\$\$ \\oint_C {E \\cdot d\\ell  =  - \\frac{d}{{dt}}} \\int_S {B_n dA} \$\$<br>
  
  
  Bohr Radius

\\( a_0  = \\frac{{\\hbar ^2 }}{{m_e ke^2 }} \\)<br>

Relationship between Energy and Principal Quantum Number

\\( E_n  =  - R_H \\left( {\\frac{1}{{n^2 }}} \\right) = \\frac{{ - 2.178 \\times 10^{ - 18} }}{{n^2 }}joule \\)<br>
  
</p>

      
      """);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Flutter TeX'),
        ),
        body: new Center(
          child: InAppWebView(
              initialUrl:
                  "http://localhost:8080/assets/MathJax/index.html?data=$teX"),
        ),
      ),
    );
  }
}
