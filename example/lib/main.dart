import 'package:flutter/material.dart';
import 'package:flutter_tex_example/home_page.dart' deferred as home_page;

main() {
  runApp(const FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  const FlutterTeXExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: home_page.loadLibrary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return home_page.TeXViewFullExample();
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
