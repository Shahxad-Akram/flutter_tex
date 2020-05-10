# Flutter TeX

[![GitHub stars](https://img.shields.io/github/stars/shah-xad/flutter_tex?style=social)](https://github.com/shah-xad/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png" alt=""/>

A Flutter Package to render so many types of equations based on **LaTeX** and **TeX**, most commonly used are as followings:

- **Mathematics / Maths Equations** (Algebra, Calculus, Geometry, Geometry etc...)

- **Physics Equations**

- **Signal Processing Equations**

- **Chemistry Equations**

- **Statistics / Stats Equations**

- It also includes full **HTML** with **JavaScript** support.

Rendering of equations depends on [mini-mathjax](https://github.com/electricbookworks/mini-mathjax) a simplified version of [MathJax](https://github.com/mathjax/MathJax/) and [Katex](https://github.com/KaTeX/KaTeX) JavaScript libraries.

This package mainly depends on [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) plugin.



## Use this package as a library in your flutter Application

**1:** Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_tex: ^3.6.1+1
```


**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.


**3:** For **Android** Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.
```xml
<application
       android:usesCleartextTraffic="true">
</application>
```

and permissions

```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
```

For **iOS** add following code in your `<project-directory>/ios/Runner/Info.plist`
```plist

<key>NSAppTransportSecurity</key>
  
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>

<key>io.flutter.embedded_views_preview</key> <true/> 
```

**4:** Now in your Dart code, you can use:

```dart
import 'package:flutter_tex/flutter_tex.dart'; 
```

**5:** Now you can use TeXHTML widget like this.
```dart
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';


class FlutterTeXExampleMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: TeXView(
            renderingEngine: TeXViewRenderingEngine.katex(),
            children: [
              TeXViewContainer(id: "container_0", children: [
                TeXViewTeX(
                  r"<h3>Quadratic Equation</h3>",
                  style: TeXViewStyle(
                    textAlign: TeXViewTextAlign.Center,
                    backgroundColor: Colors.red,
                    contentColor: Colors.white,
                  ),
                  id: "tex_0",
                ),
                TeXViewTeX(r"""<p>                                
                           When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                           $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                    style: TeXViewStyle.fromCSS(
                        "color:white;background-color:green;padding:20px"),
                    id: "tex_1"),
              ])
            ],
            style: TeXViewStyle(
              margin: TeXViewMargin.all(20),
              elevation: 10,
              borderRadius: TeXViewBorderRadius.all(20),
              border: TeXViewBorder.all(
                TeXViewBorderDecoration(
                    borderColor: Colors.blue,
                    borderStyle: TeXViewBorderStyle.Solid,
                    borderWidth: 5),
              ),
              backgroundColor: Colors.white,
            ),
            loadingWidget: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Rendering with ")
                ],
              ),
            ),
            onTap: (childID) {
              print("TeXView $childID is tapped.");
            }),
      ),
    );
  }
}

```

Use **Katex RenderingEngine** for fast render and  **MathJax RenderingEngine** for quality render.



# Api Changes since flutter_tex:^3.6.1
* `TeXViewChild` removed, `TeXViewContainer` child of `TeXView` added and `TeXViewTeX` child of `TeXViewChild` added which holds `TeX` data styling.
* Minor API Changes for `TeXViewBorder` `TeXViewMargin` `TeXViewPadding` and `TeXViewBorderRadius`.
* `RenderingEngine` has been replaced with `TeXViewRenderingEngine`
* Katex Configurations added.

# Api Changes since flutter_tex:^3.5.0
- `teXHTML` has been removed from the API and replaced by the `children` which contains the list of `TeXViewChild` for more information please see the example. For any problem please report the issue.

# Api Usage.

- `children:` A list of `TeXViewContainer`

- `TeXViewContainer:` A list of `TeXViewTeX`

- `TeXViewTeX` holds TeX data by using a raw string e.g.
`r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """` You can also put javascript code in it.<br>
    If you load **Network Image** in your document you should go like this.
    ``` 
    <img onload="onTeXViewRenderComplete();"
    src="https://img.wallpapersafari.com/desktop/1920/1080/84/27/nMWzIB.jpg" />
    ```
  Do put this<br>
  ```onload="onTeXViewRenderComplete();"```<br>
   in your img tag, it'll recalculate the height of the page and rerender the page after the image loading completes.

- `TeXViewStyle()` You can style each and everything using `TeXViewStyle()` or by using custom `CSS` code by `TeXViewStyle.fromCSS()` where you can pass hard coded String containing CSS code. For more information please check the example.
    
- `renderingEngine:` Render Engine to render TeX (Default is Katex Rendering Engine).
  
- `height:` Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  
- `loadingWidget:` Show a loading widget before rendering completes.

- `showLoadingWidget:` Show or hide loadingWidget.
  
- `onTap:` On Tap Callback.

- `onRenderFinished:` Callback with the rendered page height, when TEX rendering finishes.
  
- `onPageFinished:` Callback when TeXView loading finishes.
  
- `keepAlive:` Keep widget Alive . (True by default).


# Demo app is available on Google Play.
<a href='https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

[Example Source](https://github.com/shah-xad/flutter_tex/tree/master/example)

# Screenshots

Screenshot# 01             |  Screenshot# 02
:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_1.png"/> | <img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_2.png"/>

Screenshot# 03             |  Screenshot# 04
:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_3.png"/> | <img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_4.png"/>

## To Do:
- ~~Speed Optimizations as it's a bit slow rendering speed. It takes 1-2 seconds to render after application loaded.~~ (Solved by adding Katex Support)
- Poor support for Flutter Web, Please don't use that for production.

## Cautions:
- Please avoid using too many TeXViews in a single page, because this is based on [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) a complete web browser. Which may cause slowing down your app.
