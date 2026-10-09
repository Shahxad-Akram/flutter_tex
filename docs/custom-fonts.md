# Custom Fonts

You can apply custom fonts to your mathematical documents in `TeXView` by declaring CSS `@font-face` rules in a style file.

---

## Directory Setup

Place your font files (e.g. `.ttf`, `.otf`, or `.woff`) inside your project's `assets/` folder, and add a style sheet named `flutter_tex.css`:

```
your_flutter_app/
├── assets/
│   ├── fonts/
│   │   ├── KaTeX_Main-Regular.ttf
│   │   └── CustomMathFont.ttf
│   └── flutter_tex.css       <-- Font declarations
├── lib/
│   └── main.dart
└── pubspec.yaml
```

---

## Step-by-Step Guide

### 1. Define `@font-face` in `assets/flutter_tex.css`

Inside `assets/flutter_tex.css`, define the font family and relative path to the font file:

```css
@font-face {
  font-family: 'custom_math';
  src: url("fonts/CustomMathFont.ttf");
}

@font-face {
  font-family: 'katex_serif';
  src: url("fonts/KaTeX_Main-Regular.ttf");
}
```

### 2. Register Assets in `pubspec.yaml`

Include both the stylesheet and your fonts in your `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/flutter_tex.css
    - assets/fonts/
```

### 3. (Web Only) Link in `web/index.html`

If deploying to Flutter Web, link the CSS file inside `<head>` in `web/index.html`:

```html
<head>
  ...
  <link rel="stylesheet" href="assets/assets/flutter_tex.css" type="text/css">
  <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
  <script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
</head>
```

---

## Applying the Font in Dart

Use `TeXViewFontStyle` inside `TeXViewStyle` to assign your custom typeface, size, and weight:

```dart
TeXView(
  child: TeXViewDocument(
    r"Typography with custom font: \( \int e^x dx = e^x + C \)",
    style: const TeXViewStyle(
      fontStyle: TeXViewFontStyle(
        fontFamily: 'custom_math',
        fontSize: 18,
        sizeUnit: TeXViewSizeUnit.pt,
        fontWeight: TeXViewFontWeight.w500,
      ),
    ),
  ),
)
```

---

## Font Style Options

### Size Units (`TeXViewSizeUnit`)

| Unit | CSS Equivalent | Description |
|:---|:---|:---|
| `TeXViewSizeUnit.pixels` | `px` | Fixed pixel dimensions (default). |
| `TeXViewSizeUnit.pt` | `pt` | Points (1pt = 1/72 inch). Common for print and academic typography. |
| `TeXViewSizeUnit.em` | `em` | Relative to the parent element's font size. |
| `TeXViewSizeUnit.percent`| `%` | Scaled percentage relative to the parent. |

### Font Weights (`TeXViewFontWeight`)

Supports standard CSS weights: `normal`, `bold`, `bolder`, `lighter`, and numerical weights from `w100` through `w900`.