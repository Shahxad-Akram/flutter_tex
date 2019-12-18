# Flutter TeX

A Flutter Package to render so many types of equations based on **LaTeX**, most commonly used are as followings:

- **Mathematics / Maths Equations** (Algebra, Calculus, Geometry, Geometry etc...)

- **Physics Equations**

- **Signal Processing Equations**

- **Chemistry Equations**

- **Statistics / Stats Equations**

- It also includes full **HTML** with **JavaScript** support.

Rendering of equations depends on [mini-mathjax](https://github.com/electricbookworks/mini-mathjax) a simplified version of [MathJax](https://github.com/mathjax/MathJax/) a JavaScript library.

This package mainly depends on [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) plugin.


**Only Tested on Android not on iOS because I don't own a Mac.**

## Use this package as a library in your flutter Application

**1:** Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_tex: ^1.0.10
```

**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

**3:** Now in your Dart code, you can use:

```dart
import 'package:flutter_tex/flutter_tex.dart';
```
**4:** Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.
```xml
<application
       android:usesCleartextTraffic="true">
</application>
```
For iOS add following code in your `<project-directory>/ios/Runner/Info.plist`
```plist

<key>NSAppTransportSecurity</key>
  
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>

<key>io.flutter.embedded_views_preview</key> <true/> 
```

## Example

[Complete working application Example](https://github.com/shahxadakram/flutter_tex/tree/master/example)

# Screenshots

<img height="800" src="https://github.com/shahzadakram67/flutter_tex/blob/master/screenshots/Screenshot_1.png" alt="FlutterTeXMaths">

<img height="800" src="https://github.com/shahzadakram67/flutter_tex/blob/master/screenshots/Screenshot_2.png" alt="FlutterTeXMaths">

[![Tweet Flutter_TeX](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=A%20Flutter%20Package%20to%20render%20Mathematics%2C%20Physics%20and%20Chemistry%20Equations%20based%20on%20LaTeX%20with%20full%20HTML%20support.&url=https://github.com/shahzadakram67/flutter_tex&via=shahzadakram67&hashtags=flutter,flutter_tex,latex,equations)
