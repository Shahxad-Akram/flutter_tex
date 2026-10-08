# TeXView

`TeXView` is a comprehensive document container designed for rendering rich content combining mathematics, HTML markup, Markdown, custom CSS styles, media, and interactive touch callbacks.

On mobile and desktop platforms, `TeXView` runs on top of a WebView (`webview_flutter_plus`). On Flutter Web, it embeds an optimized `iframe`.

!!! warning "Performance Tip: Use Sparingly in Scrollable Lists"
    Because `TeXView` creates a WebView instance, having dozens of separate `TeXView` widgets inside a `ListView.builder` can consume significant memory and cause frame drops.
    
    - **For standalone formulas or text paragraphs:** Use [`Math2SVG`](math-2-svg.md) or [`TeXWidget`](tex-widget.md) (pure Flutter, no WebView).
    - **When using `TeXView`:** Place a **single** `TeXView` widget on the page, and arrange multiple sections inside a `TeXViewColumn`.

---

## Basic Example

Here is a full document structure containing a header, an image, and a mathematical equation:

```dart
TeXView(
  child: TeXViewColumn(
    children: [
      TeXViewDocument(
        r"<h2>Quadratic Formula</h2>",
        style: const TeXViewStyle(
          textAlign: TeXViewTextAlign.center,
          contentColor: Colors.indigo,
        ),
      ),
      TeXViewContainer(
        child: TeXViewImage.network(
          'https://raw.githubusercontent.com/Shahxad-Akram/flutter_tex/main/example/assets/flutter_tex_banner.png',
        ),
        style: const TeXViewStyle(
          margin: TeXViewMargin.all(10),
          borderRadius: TeXViewBorderRadius.all(16),
        ),
      ),
      TeXViewDocument(
        r"""
        <p>When \(a \ne 0\), the roots of \(ax^2 + bx + c = 0\) are given by:</p>
        $$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$
        """,
        style: TeXViewStyle.fromCSS("padding: 12px; background-color: #f5f5f5; border-radius: 8px;"),
      ),
    ],
  ),
  style: const TeXViewStyle(
    margin: TeXViewMargin.all(16),
    padding: TeXViewPadding.all(16),
    backgroundColor: Colors.white,
    elevation: 4,
    borderRadius: TeXViewBorderRadius.all(12),
  ),
  loadingWidgetBuilder: (context) => const Center(
    child: CircularProgressIndicator(),
  ),
)
```

---

## Widget Catalog (`TeXViewWidget`)

Inside `TeXView`, you assemble your document using compound widgets that implement `TeXViewWidget`:

### 1. `TeXViewDocument`
Renders raw HTML combined with LaTeX formulas:

```dart
TeXViewDocument(
  r"""
  <p>Chemical reaction:</p>
  $$ \ce{CO2 + C -> 2 CO} $$
  """,
  style: const TeXViewStyle(margin: TeXViewMargin.all(8)),
)
```

### 2. `TeXViewMarkdown`
Renders formatted Markdown with embedded LaTeX equations:

```dart
TeXViewMarkdown(
  r"""
  # Kinematics
  A particle with velocity $v$ and acceleration $a$:
  - Position: $$x(t) = x_0 + v_0 t + \frac{1}{2} a t^2$$
  - Velocity: $$v(t) = v_0 + a t$$
  """,
)
```

### 3. `TeXViewColumn`
Arranges a vertical list of `TeXViewWidget` items:

```dart
TeXViewColumn(
  children: [
    widgetOne,
    widgetTwo,
    widgetThree,
  ],
  style: const TeXViewStyle(padding: TeXViewPadding.all(10)),
)
```

### 4. `TeXViewContainer`
Wraps a single `TeXViewWidget` with custom spacing, background colors, or borders:

```dart
TeXViewContainer(
  child: TeXViewDocument(r"\( \int_0^1 x \, dx = \frac{1}{2} \)"),
  style: const TeXViewStyle(
    backgroundColor: Colors.amber,
    borderRadius: TeXViewBorderRadius.all(8),
  ),
)
```

### 5. `TeXViewImage`
Loads images from assets or the network:

```dart
// Network image
TeXViewImage.network('https://example.com/diagram.png')

// Local asset (declared in pubspec.yaml)
TeXViewImage.asset('assets/images/diagram.png')
```

### 6. `TeXViewVideo`
Embeds YouTube or direct network video players:

```dart
TeXViewVideo.youtube("https://www.youtube.com/watch?v=YiNbVEXV_NM")
```

### 7. `TeXViewDetails`
Creates an expandable/collapsible `<details>` accordion:

```dart
TeXViewDetails(
  title: "Click to reveal solution",
  body: TeXViewDocument(r"$$x = 42$$"),
  style: const TeXViewStyle(
    backgroundColor: Colors.blueGrey,
    borderRadius: TeXViewBorderRadius.all(8),
  ),
)
```

### 8. `TeXViewInkWell` (Interactivity & Taps)
Responds to touch gestures with an optional ripple effect and a callback receiving the widget's unique `id`. Great for quizzes and interactive diagrams:

```dart
TeXViewInkWell(
  id: "option_a",
  rippleEffect: true,
  child: TeXViewDocument(r"<b>Option A:</b> \(x = 0\)"),
  style: const TeXViewStyle(
    padding: TeXViewPadding.all(10),
    margin: TeXViewMargin.all(6),
    borderRadius: TeXViewBorderRadius.all(8),
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(borderColor: Colors.blue, borderWidth: 1),
    ),
  ),
  onTap: (selectedId) {
    print("User tapped item: $selectedId");
  },
)
```

---

## Styling with `TeXViewStyle`

You can style widgets using Dart properties or direct CSS:

### Option A: Dart Style Properties

```dart
const TeXViewStyle(
  padding: TeXViewPadding.all(12),
  margin: TeXViewMargin.symmetric(vertical: 8, horizontal: 16),
  backgroundColor: Colors.white,
  contentColor: Colors.black87,
  textAlign: TeXViewTextAlign.center,
  elevation: 3,
  borderRadius: TeXViewBorderRadius.all(12),
  border: TeXViewBorder.all(
    TeXViewBorderDecoration(
      borderColor: Colors.grey,
      borderStyle: TeXViewBorderStyle.solid,
      borderWidth: 1,
    ),
  ),
  overflow: TeXViewOverflow.auto,
)
```

### Option B: Raw CSS

If you prefer writing native CSS directly, use the `TeXViewStyle.fromCSS` constructor:

```dart
TeXViewStyle.fromCSS(
  "padding: 16px; background: linear-gradient(to right, #ece9e6, #ffffff); border-radius: 12px; font-size: 1.1em;",
)
```

---

## API Reference: `TeXView`

### Properties

| Property | Type | Default | Description |
|:---|:---|:---|:---|
| `child` | `TeXViewWidget` | *required* | The root document content (e.g. `TeXViewColumn` or `TeXViewDocument`). |
| `style` | `TeXViewStyle?` | `null` | Style applied to the outer container. |
| `heightOffset` | `double` | `5.0` | Extra padding added to the calculated rendered height to prevent unnecessary scrollbars. |
| `loadingWidgetBuilder` | `Widget Function(BuildContext)?` | `null` | Builder displaying a widget while the WebView/DOM initializes. |
| `onRenderFinished` | `Function(double height)?` | `null` | Callback triggered once rendering completes, providing the total content height. |
| `wantKeepAlive` | `bool` | `true` | Keeps the widget alive inside scrollable lists to avoid disposing the WebView on scroll. |