# Installation & Setup

## 1. Add the Dependency

Add `flutter_tex` to your project using the Flutter CLI:

```bash
flutter pub add flutter_tex
```

Or manually add it to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_tex: ^{{ flutter_tex_version }}
```

Then fetch packages:

```bash
flutter pub get
```

---

## 2. Platform Configuration

`flutter_tex` is **100% offline**, but on mobile and desktop platforms it uses a lightweight local server (`http://localhost:<port>`) to serve the bundled MathJax engine to an internal headless rendering worker. Modern operating systems require permissions to access `localhost` or load local HTTP traffic.

Follow the setup for each platform you are targeting:

### Android

Open `<project-directory>/android/app/src/main/AndroidManifest.xml`:

1. **Allow cleartext HTTP traffic** on the `<application>` tag (required by Android 9+ to connect to the internal `localhost` server):

```xml
<application
    android:label="Your App"
    android:icon="@mipmap/ic_launcher"
    android:usesCleartextTraffic="true">
    ...
</application>
```

2. **Add internet permission and package queries** outside `<application>` (for localhost access and opening external links via `url_launcher`):

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />

    <queries>
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

    <application ...>
        ...
    </application>
</manifest>
```

---

### iOS

Open `<project-directory>/ios/Runner/Info.plist` and add the following keys inside `<dict>`:

```xml
<!-- Allow connection to the internal localhost server -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

<!-- URL schemes allowed for in-app link opening -->
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>https</string>
    <string>http</string>
    <string>tel</string>
    <string>mailto</string>
</array>
```

---

### Web

For Flutter Web, MathJax scripts and styles must be loaded by the browser host page.

Add the following tags inside the `<head>` block of `<project-directory>/web/index.html`:

```html
<head>
  ...
  <!-- Optional custom styling/scripts from your app assets -->
  <link rel="stylesheet" href="assets/assets/flutter_tex.css" type="text/css">
  <script src="assets/assets/flutter_tex.js" type="text/javascript"></script>

  <!-- Core Flutter TeX assets (provided by the package) -->
  <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
  <script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
</head>
```

!!! note "Web Architecture"
    On Web, `flutter_tex` communicates directly with MathJax in the browser's JavaScript context via `dart:js_interop`. There is no WebView overhead on web builds.

---

### macOS

macOS Flutter apps run in an App Sandbox by default. To allow the app to communicate with the local rendering server, open both:

- `macos/Runner/DebugProfile.entitlements`
- `macos/Runner/Release.entitlements`

And add the client network entitlement:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

---

## 3. Server Initialization in Dart

Before rendering formulas or widgets, start the rendering server in your `main()` entrypoint. This spins up the local MathJax worker on mobile/macOS or connects JS interop on Web.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

void main() async {
  // 1. Ensure Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Start the rendering engine
  await TeXRenderingServer.start();

  // 3. Launch your app
  runApp(const MyApp());
}
```

!!! tip "Is `TeXRenderingServer.start()` safe on Web?"
    Yes! On Web, `TeXRenderingServer.start()` simply initializes JS interop listeners. Calling `await TeXRenderingServer.start();` works uniformly across Android, iOS, Web, and macOS without conditional platform checks.

---

## 4. Verification Checklist

To confirm everything is configured correctly:

- [x] `android:usesCleartextTraffic="true"` is present in AndroidManifest.xml.
- [x] `NSAllowsArbitraryLoads` is set to `true` in iOS `Info.plist`.
- [x] `<script>` tags for MathJax are added to `web/index.html` (if targeting Web).
- [x] `WidgetsFlutterBinding.ensureInitialized()` and `await TeXRenderingServer.start()` run in `main()`.
- [x] Test a simple formula with `Math2SVG(math: r"E = mc^2")`.