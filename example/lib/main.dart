import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'teXHTML.dart';

main() async {
  runApp(FlutterTeX());
}

class FlutterTeX extends StatefulWidget {
  @override
  _FlutterTeXState createState() => _FlutterTeXState();
}

class _FlutterTeXState extends State<FlutterTeX> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter TeX Example"),
        ),
        body: TeXView(
          teXHTML: teXHTML,
        ),
      ),
    );
  }
}
