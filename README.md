# Flutter TeX

[![GitHub stars](https://img.shields.io/github/stars/shah-xad/flutter_tex?style=social)](https://github.com/shah-xad/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png"/>

A Flutter Package to render so many types of equations based on **LaTeX**, most commonly used are as followings:

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
  flutter_tex: ^3.1.4
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
    TeXView(
          teXHTML: r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """,
          renderingEngine: RenderingEngine.Katex,  // Katex for fast render and MathJax for quality render.
          onRenderFinished: (height) {
                print("Widget Height is : $height");
                },   
          onPageFinished: (string) {
                print("Page Loading finished");
              },
        )
```

Use **Katex RenderingEngine** for fast render and  **MathJax RenderingEngine** for quality render.

# Api Usage.
- `teXHTML:` Raw String containing HTML and TEX Code e.g.<br>
    ```
 
    String textHTML = r"""
    <style>
     #myDiv 
     {
     background-color: red;
     }
    </style>
    
    <div id='myDiv'>
        $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$
    </div>
    """
    ```
    You can also put javascript code in it.<br>
    
    If you load **Network Image** in your document you should go like this.
    
    ``` 
    <img onload="RenderedWebViewHeight.postMessage(document.getElementById('teXHTML').clientHeight);"
    src="https://img.wallpapersafari.com/desktop/1920/1080/84/27/nMWzIB.jpg" />
    ```
  Do put this<br>
  ```onload="RenderedWebViewHeight.postMessage(document.getElementById('teXHTML').clientHeight);"```<br>
  in your img tag, it'll recalculate the height of the page and rerender the page after the image loading completes.

- `renderingEngine:` Render Engine to render TeX (Default is Katex Rendering Engine).
  
- `height:` Fixed Height for TeXView. (Avoid using fixed height for TeXView, let it to adopt the height by itself)
  
- `loadingWidget:` Show a loading widget before rendering completes.
  
- `onTap:` On Tap Callback.

- `onRenderFinished:` Callback with the rendered page height, when TEX rendering finishes.
  
- `onPageFinished:` Callback when TeXView loading finishes.
  
- `keepAlive:` Keep widget Alive . (True by default).



# Demo app is available on Google Play.
<a href='https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

[Example Application Source](https://github.com/shah-xad/flutter_tex/tree/master/example)

# Screenshots

Screenshot# 01             |  Screenshot# 02
:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_1.png"/> | <img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_2.png"/>

Screenshot# 03             |  Screenshot# 04
:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_3.png"/> | <img src="https://raw.githubusercontent.com/shah-xad/flutter_tex/master/screenshots/screenshot_4.png"/>

## To Do:
- ~~Speed Optimizations as it's a bit slow rendering speed. It takes 1-2 seconds to render after application loaded.~~ (Solved by adding Katex Support)
- Beta support for Flutter Web, Automatically calculation of TeXView Height in Flutter Web and much more to do for Flutter Web.

## Cautions:
- Please avoid using too many TeXViews in a single page, because this is based on [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) a complete web browser. Which may cause to slow down your app.
