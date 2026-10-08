# Troubleshooting & FAQ

Practical solutions to the most common setup and rendering issues.

---

## 1. Formulas are blank or crash with `Null check operator used on null value`

### Cause
The local rendering engine was not started before a math widget was built.

### Fix
Ensure you initialize `WidgetsFlutterBinding` and start `TeXRenderingServer` in your `main()` function:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TeXRenderingServer.start(); // <-- Required before runApp
  runApp(const MyApp());
}
```

---

## 2. Blank screen on Android or `ERR_CLEARTEXT_NOT_PERMITTED`

### Cause
On Android 9 (API 28) and higher, cleartext (unencrypted HTTP) traffic is disabled by default. Because `flutter_tex` uses an internal `http://localhost:<port>` server to communicate with MathJax offline, Android blocks the connection.

### Fix
Open `android/app/src/main/AndroidManifest.xml` and add `android:usesCleartextTraffic="true"` to your `<application>` tag:

```xml
<application
    android:label="Your App"
    android:icon="@mipmap/ic_launcher"
    android:usesCleartextTraffic="true"> <!-- Required -->
    ...
</application>
```

---

## 3. Backslashes disappear or cause parse errors in formulas

### Cause
In standard Dart strings, `\` is treated as an escape character (e.g. `\n` is a newline, `\t` is a tab). Writing `"\frac{1}{2}"` will produce unintended escape characters.

### Fix
Always use Dart **raw string literals** prefixed with `r`:

```dart
// ❌ WRONG: Escapes will corrupt LaTeX
Math2SVG(math: "\frac{1}{2}")

// ✅ CORRECT: Raw string preserves all backslashes
Math2SVG(math: r"\frac{1}{2}")
```

---

## 4. Choppy scrolling or lag inside a `ListView`

### Cause
`TeXView` is based on a platform WebView. Embedding multiple `TeXView` instances in a `ListView.builder` creates multiple heavy WebViews, causing high memory usage and frame drops.

### Fix
- For lists containing math formulas, use **[`Math2SVG`](math-2-svg.md)** or **[`TeXWidget`](tex-widget.md)**. Both compile directly to native Flutter vector graphics (`flutter_svg`) and scroll smoothly at 60/120 FPS.
- Set `wantKeepAlive: true` on `Math2SVG` so that once an equation is rendered, its SVG remains cached and doesn't re-render as you scroll back and forth.

---

## 5. Formulas are clipped or show unwanted scrollbars in `TeXView`

### Cause
Different device fonts and display scalers may compute slightly different HTML heights than the initial WebView measurement.

### Fix
Adjust the `heightOffset` on `TeXView` to provide breathing room:

```dart
TeXView(
  heightOffset: 20.0, // Increase offset (default is 5.0)
  child: ...,
)
```

You can also set `overflow: TeXViewOverflow.hidden` or `auto` on your `TeXViewStyle`:

```dart
TeXViewStyle(
  overflow: TeXViewOverflow.auto,
)
```

---

## 6. Formulas don't render on iOS simulator or device

### Cause
iOS App Transport Security (ATS) blocks non-HTTPS connections, preventing access to `http://localhost`.

### Fix
Add the ATS exception to `ios/Runner/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

## 7. Web: MathJax fails to load or 404 in browser console

### Cause
Missing core script tags in your web template.

### Fix
Verify that `<project-directory>/web/index.html` includes the following scripts inside `<head>`:

```html
<script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
<script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
```
