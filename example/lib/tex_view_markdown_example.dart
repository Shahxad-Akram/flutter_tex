import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

String _markdownFlutterTeX = r"""
# flutter_tex
[![GitHub stars](https://img.shields.io/github/stars/shah-xad/flutter_tex?style=social)](https://github.com/shah-xad/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

# Contents
* [About](#about)
* [Demo Video](#demo-video)
* [How to use?](#how-to-use)
   * [Android](#android)
   * [iOS](#ios)
   * [Web](#web)    
* [Examples](#examples)
    * [Quick Example](#quick-example)
    * [TeXView Document Example](#texview-document-example)
    * [TeXView Quiz Example](#texview-quiz-example)
    * [TeXView Custom Fonts Example](#texview-custom-fonts-example)
    * [TeXView Image and Video Example](#texview-image-and-video-example)
    * [TeXView InkWell Example](#texview-inkwell-example)
    * [Complete Example](#complete-example)
* [Demo Application](#application-demo)
* [Demo Web](#web-demo)
* [Api Changes](#api-changes)
* [Api Usage](#api-usage)
* [Todo](#to-do)
* [Cautions](#cautions)

# About
A Flutter Package to render **fully offline** so many types of equations based on **LaTeX** and **TeX**, most commonly used are as followings:

- **Mathematics / Maths Equations** (Algebra, Calculus, Geometry, Geometry etc...)

- **Physics Equations**

- **Signal Processing Equations**

- **Chemistry Equations**

- **Statistics / Stats Equations**

- It also includes full **HTML** with **JavaScript** support.

Rendering of equations depends on [mini-mathjax](https://github.com/electricbookworks/mini-mathjax) a simplified version of [MathJax](https://github.com/mathjax/MathJax/) and [Katex](https://github.com/KaTeX/KaTeX) JavaScript libraries.

This package mainly depends on [**webview_flutter_plus**](https://pub.dartlang.org/packages/webview_flutter_plus) a very powerful extension of [webview_flutter](https://pub.dartlang.org/packages/webview_flutter).


# Demo Video

## [Click to Watch Demo on Youtube](https://www.youtube.com/watch?v=YiNbVEXV_NM)

# How to use?
**1:** Add flutter_tex latest  [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex) version under dependencies to your package's pubspec.yaml file.

```yaml
dependencies:
  flutter_tex: ^3.6.6+6
``` 


**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.


**3:** Now you need to put the following implementations in `Android`, `iOS`, and `Web` respectively.

### Android
Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.
```xml
<application
       android:usesCleartextTraffic="true">
</application>
```

It completely works offline, without internet connection, but these are required permissions to work properly:

```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
```

It'll still work in debug mode without permissions, but it won't work in release application without mentioned permissions.

### iOS
Add following code in your `<project-directory>/ios/Runner/Info.plist`
```plist
<key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>Example
<key>io.flutter.embedded_views_preview</key> <true/> 
```

### Web
For Web support you need to put `<script src="assets/packages/flutter_tex/js/flutter_tex.js"></script>` in `<head>` tag of your `<project-directory>/web/index.html` like this.
```html
<head>
    <meta charset="UTF-8">
    <title>Flutter TeX</title>
    <script src="assets/packages/flutter_tex/js/flutter_tex.js"></script>
</head>
```

**4:** Now in your Dart code, you can use:

```dart
import 'package:flutter_tex/flutter_tex.dart'; 
```

**5:** Now you can use TeXView as a widget:

# Examples

### TeXView Document Example
#### [TeXView Document Example](https://github.com/shah-xad/flutter_tex/blob/master/example/lib/tex_view_document_example.dart)

### TeXView Quiz Example
#### [TeXView Quiz Example](https://github.com/shah-xad/flutter_tex/blob/master/example/lib/tex_view_quiz_examples.dart)

### TeXView Custom Fonts Example
#### [TeXView Custom Fonts Example](https://github.com/shah-xad/flutter_tex/blob/master/example/lib/tex_view_fonts_example.dart)

### TeXView Image and Video Example
#### [TeXView Image and Video Example](https://github.com/shah-xad/flutter_tex/blob/master/example/lib/tex_view_image_video_examples.dart)

### TeXView InkWell Example
#### [TeXView InkWell Example](https://github.com/shah-xad/flutter_tex/blob/master/example/lib/tex_view_ink_well_examples.dart)

### Complete Example
#### [Complete Example Code](https://github.com/shah-xad/flutter_tex/tree/master/example)


# Web Demo.
You can find web demo at [https://flutter-tex.web.app](https://flutter-tex.web.app)

# Api Changes.
* Please see [CHANGELOG.md](https://github.com/shah-xad/flutter_tex/blob/master/CHANGELOG.md).

# Api Usage.
- `children:` A list of `TeXViewWidget`

- **`TeXViewWidget`**
    - `TeXViewDocument` holds TeX data by using a raw string e.g. `$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>` You can also put HTML and Javascript code in it.
    - `TeXViewContainer` holds a single `TeXViewWidget` with styling.
    - `TeXViewImage` renders image from assets or network.
    - `TeXViewColumn` holds a list of `TeXViewWidget` vertically.
    - `TeXViewInkWell` for listening tap events. Its child and id is mandatory.
    - `TeXViewGroup` a group of `TeXViewGroupItem` usually used to create quiz layout.
            
- `TeXViewStyle()` You can style each and everything using `TeXViewStyle()` or by using custom `CSS` code by `TeXViewStyle.fromCSS()` where you can pass hard coded String containing CSS code. For more information please check the example.
    
- `renderingEngine:` Render Engine to render TeX (Default is Katex Rendering Engine). Use **Katex RenderingEngine** for fast render and  **MathJax RenderingEngine** for quality render.

- `loadingWidgetBuilder:` Show a loading widget before rendering completes.

- `onRenderFinished:` Callback with the rendered page height, when TEX rendering finishes.
  
- `onTeXViewCreated:` Callback when TeXView loading finishes.
  
- `keepAlive:` Keep widget Alive. (True by default).

For more please see the [Example](https://github.com/shah-xad/flutter_tex/tree/master/example).

""";

class TeXViewMarkdownExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewMarkdownExamples(
      {super.key, this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeXViewMarkdown"),
      ),
      body: TeXView(
        renderingEngine: renderingEngine,
        child: TeXViewMarkdown(_markdownFlutterTeX),
        style: const TeXViewStyle(
          margin: TeXViewMargin.all(10),
          padding: TeXViewPadding.all(20),
          elevation: 10,
          borderRadius: TeXViewBorderRadius.all(25),
          border: TeXViewBorder.all(
            TeXViewBorderDecoration(
                borderColor: Colors.blue,
                borderStyle: TeXViewBorderStyle.solid,
                borderWidth: 5),
          ),
          backgroundColor: Colors.white,
        ),
        loadingWidgetBuilder: (context) => const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Rendering...")
            ],
          ),
        ),
      ),
    );
  }
}
