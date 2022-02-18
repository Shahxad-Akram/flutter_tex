import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewInkWellExample extends StatefulWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewInkWellExample(
      {Key? key, this.renderingEngine = const TeXViewRenderingEngine.katex()})
      : super(key: key);

  @override
  _TeXViewInkWellExampleState createState() => _TeXViewInkWellExampleState();
}

class _TeXViewInkWellExampleState extends State<TeXViewInkWellExample> {
  final TeXViewStyle _teXViewStyle = const TeXViewStyle(
    margin: TeXViewMargin.all(10),
    padding: TeXViewPadding.all(10),
    borderRadius: TeXViewBorderRadius.all(10),
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Colors.blue,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 2),
    ),
  );

  String tappedId = "No InkWell!!! Please Tap an InkWell";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TeXViewInkWell: You tapped: $tappedId"),
      ),
      body: TeXView(
          renderingEngine: widget.renderingEngine,
          child: TeXViewColumn(children: [
            TeXViewInkWell(
                child: const TeXViewDocument(
                    r"""<h2>\( \rm\\TeXViewInkWell\) 1 with ripple</h2>"""),
                style: _teXViewStyle,
                id: "inkwell_1",
                rippleEffect: true,
                onTap: tapCallbackHandler),
            TeXViewInkWell(
                child: const TeXViewDocument(
                    r"""<h2>\( \rm\\TeXViewInkWell\) 2 without ripple</h2>"""),
                style: _teXViewStyle,
                id: "inkwell_2",
                rippleEffect: false,
                onTap: tapCallbackHandler),
            TeXViewInkWell(
                child: const TeXViewDocument(
                    r"""<h2>\( \rm\\TeXViewInkWell\) 3 with ripple</h2>"""),
                style: _teXViewStyle,
                id: "inkwell_3",
                rippleEffect: true,
                onTap: tapCallbackHandler),
            TeXViewInkWell(
                child: const TeXViewDocument(
                    r"""<h2>\( \rm\\TeXViewInkWell\) 4 without ripple</h2>"""),
                style: _teXViewStyle,
                id: "inkwell_4",
                rippleEffect: false,
                onTap: tapCallbackHandler),
          ]),
          style: const TeXViewStyle(
            margin: TeXViewMargin.all(5),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(
              TeXViewBorderDecoration(
                  borderColor: Colors.blue,
                  borderStyle: TeXViewBorderStyle.solid,
                  borderWidth: 5),
            ),
            backgroundColor: Colors.white,
          ),
          loadingWidgetBuilder: (context) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering...")
                  ],
                ),
              )),
    );
  }

  void tapCallbackHandler(String id) {
    setState(() {
      tappedId = id;
    });
  }
}
