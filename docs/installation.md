# Installation

## Adding Flutter Dependency

**Minmum flutter SDK requirement is 3.27.x**

**1:** Add flutter_tex latest  [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex) version under dependencies to your package's pubspec.yaml file.

```yaml
dependencies:
  flutter_tex: ^{{ flutter_tex_version }}
``` 

**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.


**3:** Now you need to put the following implementations in `Android`, `iOS`, `MacOS` and `Web` respectively.

## Android
Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.

```xml
<application
    ...
    ...
    android:usesCleartextTraffic="true">
</application>
```

It completely works offline, without internet connection, but these are required permissions to work properly:


```xml
    <uses-permission android:name="android.permission.INTERNET" />
```
and intents in queries block: 

```xml
<queries>
  ...
  ...
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>

    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="sms" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="tel" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="mailto" />
    </intent>
    <intent>
        <action android:name="android.support.customtabs.action.CustomTabsService" />
    </intent>
</queries>
```


## iOS
Add following lines in `<project-directory>/ios/Runner/Info.plist`

```xml
<key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>
<key>io.flutter.embedded_views_preview</key> <true/> 
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>https</string>
    <string>http</string>
    <string>tel</string>
    <string>mailto</string>
</array> 
```

## Web
For Web support modify `<project-directory>/web/index.html` like this.

```html
<head>
    ...
    ...
  <link rel="stylesheet" href="../../../assets/flutter_tex.css" type="text/css">
  <script src="../../../assets/flutter_tex.js" type="text/javascript"></script>
  <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
  <script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
</head>
```

## MacOS
By default, macOS apps running in a sandboxed environment (which is the standard for Flutter apps) are not allowed to make network requests. You need to explicitly grant your application the capability to access the internet. In your Flutter project, navigate to the `macos/Runner/` directory and add the following key-value pair to `DebugProfile.entitlements` and `Release.entitlements`.

```xml
<key>com.apple.security.network.client</key>
  <true/>
```


## Initialization
In your Dart code, you can use like:

```dart
import 'package:flutter_tex/flutter_tex.dart'; 
```

Make sure to setup `TeXRenderingServer` before rendering TeX:

```dart
main() async {
  await TeXRenderingServer.start();
  runApp(...);
}
```