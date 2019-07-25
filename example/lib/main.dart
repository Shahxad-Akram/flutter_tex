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
  String text = "Old Text (Press refresh)";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter TeX Example"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    text = "New Text (After refresh)";
                  });
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
            TeXView(
              teXHTML: text,
              onRenderFinished: (height) {
                print("Height is : $height");
              },
              onPageFinished: (string) {
                print("Page Loading finished");
              },
            ),
            TeXView(
              teXHTML: teXHTML,
            ),
          ],
        ),
      ),
    );
  }
}
