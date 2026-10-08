# Math2SVG

`Math2SVG` is the recommended widget for rendering standalone mathematical equations. It compiles LaTeX, MathML, or AsciiMath into Scalable Vector Graphics (SVG) and renders them as pure Flutter widgets using `flutter_svg`.

Because `Math2SVG` outputs pure vector graphics without a WebView wrapper:

- It is lightweight and fast.
- It stays razor-sharp at any zoom level or screen density.
- It can be embedded anywhere standard Flutter widgets live — including buttons, headers, and scrollable lists.

---

## Basic Usage

Pass a raw math string to the `math` property:

```dart
Math2SVG(
  math: r"x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}",
)
```

!!! tip "Raw String Literal (`r"..."`)"
    Always prefix your LaTeX strings with `r` so Dart treats backslashes literally rather than escape codes.

---

## Supported Input Formats

Use the `teXInputType` parameter to switch between input syntaxes:

### 1. LaTeX (`MathInputType.teX`) — Default

Supports standard LaTeX math macros, chemistry (`\ce{...}`), matrices, integrals, and Greek letters.

```dart
Math2SVG(
  math: r"\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}",
  teXInputType: MathInputType.teX,
)
```

### 2. MathML (`MathInputType.mathML`)

Standard XML-based mathematical markup:

```dart
Math2SVG(
  math: r"""
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mrow>
        <msup><mi>x</mi><mn>2</mn></msup>
        <mo>+</mo>
        <mrow><mn>4</mn><mo>⁢</mo><mi>x</mi></mrow>
        <mo>+</mo>
        <mn>4</mn>
        <mo>=</mo>
        <mn>0</mn>
      </mrow>
    </math>
  """,
  teXInputType: MathInputType.mathML,
)
```

### 3. AsciiMath (`MathInputType.asciiMath`)

Intuitive, plain-text math notation:

```dart
Math2SVG(
  math: r"sum_(i=1)^n i^3 = ((n(n+1))/2)^2",
  teXInputType: MathInputType.asciiMath,
)
```

---

## Customizing Color, Size, and SvgPicture

By default, `Math2SVG` renders black SVGs with automatic containment. Use `formulaWidgetBuilder` to apply custom colors, sizes, or alignment via `SvgPicture.string`.

### Coloring Formulas (Theme & Dark Mode)

Use `ColorFilter.mode` to color the SVG:

```dart
Math2SVG(
  math: r"\mathbf{F} = m\mathbf{a}",
  formulaWidgetBuilder: (context, svg) {
    return SvgPicture.string(
      svg,
      height: 24,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary,
        BlendMode.srcIn,
      ),
    );
  },
)
```

### Responsive Formula Sizing

Scale formulas proportionally with screen width or layout constraints:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    return Math2SVG(
      math: r"E = mc^2",
      formulaWidgetBuilder: (context, svg) {
        return SvgPicture.string(
          svg,
          width: constraints.maxWidth * 0.8,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      },
    );
  },
)
```

---

## Embedding in Inline Text with `RichText`

To display an equation within a line of regular text, wrap `Math2SVG` in a `WidgetSpan` and align the placeholder to `PlaceholderAlignment.middle`:

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(fontSize: 18, color: Colors.black87),
    children: [
      const TextSpan(text: "Einstein showed that "),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Math2SVG(
          math: r"E = mc^2",
          formulaWidgetBuilder: (context, svg) => SvgPicture.string(
            svg,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
      ),
      const TextSpan(text: " describes energy-mass equivalence."),
    ],
  ),
)
```

*(Note: For entire paragraphs containing multiple equations, [`TeXWidget`](tex-widget.md) does this splitting automatically!)*

---

## Performance & Caching

`Math2SVG` has built-in performance optimizations:

1. **Synchronous Memory Cache**: Rendered SVG strings are stored in an in-memory LRU cache. When a previously rendered equation rebuilds, it displays immediately with zero asynchronous frame delay.
2. **LIFO Concurrency Queue**: When quickly scrolling through formulas, requests for newly visible equations jump to the front of the queue, while offscreen in-flight requests are automatically cancelled.
3. **`wantKeepAlive`**: When using `Math2SVG` in a `ListView`, pass `wantKeepAlive: true` to prevent the widget state from disposing when scrolled offscreen.

```dart
ListView.builder(
  itemCount: formulas.length,
  itemBuilder: (context, index) {
    return Math2SVG(
      math: formulas[index],
      wantKeepAlive: true,
    );
  },
)
```

---

## API Reference

### Properties

| Property | Type | Default | Description |
|:---|:---|:---|:---|
| `math` | `String` | *required* | The mathematical expression string to render. |
| `teXInputType` | `MathInputType` | `MathInputType.teX` | Format of the math expression: `teX`, `mathML`, or `asciiMath`. |
| `formulaWidgetBuilder` | `Widget Function(BuildContext, String svg)?` | `null` | Custom builder receiving the raw SVG string. Defaults to a standard `SvgPicture.string`. |
| `loadingWidgetBuilder` | `WidgetBuilder?` | `null` | Widget displayed while the formula is compiling. Defaults to a grey text placeholder. |
| `errorWidgetBuilder` | `Widget Function(BuildContext, Object? error)?` | `null` | Widget displayed if parsing or compilation fails. |
| `wantKeepAlive` | `bool` | `false` | Whether to maintain state when placed in lazy scrollables (e.g. `ListView`). |
