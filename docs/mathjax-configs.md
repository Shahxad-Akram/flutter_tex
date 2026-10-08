# MathJax Configuration

Flutter TeX allows you to configure MathJax behavior — including custom delimiters, macros, chemistry extensions, and SVG font caching — using a custom JavaScript configuration file.

---

## How It Works

Before MathJax initializes, Flutter TeX checks for a configuration file named `flutter_tex.js` located in your project's `assets/` directory. If present, this file defines global settings via `window.MathJax`.

```
your_flutter_app/
├── assets/
│   └── flutter_tex.js    <-- Your configuration file
├── lib/
│   └── main.dart
└── pubspec.yaml
```

---

## Setup Steps

### 1. Create `assets/flutter_tex.js`

In the root of your Flutter project, create `assets/flutter_tex.js`:

```javascript
window.MathJax = {
  tex: {
    // Math delimiters
    inlineMath: [
      ['$', '$'],
      ['\\(', '\\)']
    ],
    displayMath: [
      ['$$', '$$'],
      ['\\[', '\\]']
    ],

    // Custom LaTeX macro shortcuts
    macros: {
      // Shortcut for real numbers: \R -> \mathbb{R}
      R: '{\\mathbb{R}}',
      // Shortcut for complex numbers: \C -> \mathbb{C}
      C: '{\\mathbb{C}}',
      // Macro with an argument: \abs{x} -> \left|x\right|
      abs: ['\\left|#1\\right|', 1],
    },

    // TeX extensions
    packages: {'[+]': ['mhchem', 'ams', 'color']}
  },
  svg: {
    // 'global' caches glyphs globally, improving rendering performance
    fontCache: 'global'
  }
};
```

### 2. Register the Asset in `pubspec.yaml`

Add the file to your app's asset manifest:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/flutter_tex.js
```

### 3. (Web Only) Reference in `web/index.html`

If targeting Flutter Web, ensure your `web/index.html` loads this script inside `<head>` before the core packages:

```html
<head>
  ...
  <script src="assets/assets/flutter_tex.js" type="text/javascript"></script>
  <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
  <script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
</head>
```

---

## Common Configuration Recipes

### Defining Custom Macros

{% raw %}
```javascript
window.MathJax = {
  tex: {
    macros: {
      // Vector bold: \vecbold{v} -> \mathbf{v}
      vecbold: ['\\mathbf{#1}', 1],
      // Expected value: \E[X] -> \mathbb{E}\left[X\right]
      E: ['\\mathbb{E}\\left[#1\\right]', 1],
      // Partial derivative: \pderiv{f}{x} -> \frac{\partial f}{\partial x}
      pderiv: ['\\frac{\\partial #1}{\\partial #2}', 2],
    }
  }
};
```
{% endraw %}

You can then use these directly in Dart:

```dart
Math2SVG(math: r"\pderiv{u}{t} = \alpha \nabla^2 u")
```

### Chemical Equations (`mhchem`)

Flutter TeX bundles the `mhchem` extension, allowing you to write formatted chemistry formulas via `\ce{...}`:

```dart
Math2SVG(math: r"\ce{2H2 + O2 -> 2H2O}")
```

---

## Official MathJax Reference

For advanced settings, available TeX packages, and SVG options, consult the [MathJax Configuration Options](https://docs.mathjax.org/en/latest/options/index.html) documentation.