# TeXWidget

`TeXWidget` is a pure Flutter widget for displaying paragraphs and mixed text containing mathematical expressions. 

Unlike [Math2SVG](math-2-svg.md) (which expects a single formula) or [TeXView](tex-view.md) (which spins up a WebView), `TeXWidget` automatically tokenizes your text into normal words, inline math, and centered block equations. It renders everything using standard Flutter `RichText` and vector SVGs.

---

## Delimiters

`TeXWidget` recognizes standard LaTeX math delimiters:

| Delimiter | Type | Behavior | Example |
|:---|:---|:---|:---|
| `$...$` | Inline | Embeds directly within the current line of text | `$x = 2$` |
| `\(...\)` | Inline | Embeds directly within the current line of text | `\(a + b = c\)` |
| `$$...$$` | Display | Breaks into a new block, centered with vertical margins | `$$E = mc^2$$` |
| `\[...\]` | Display | Breaks into a new block, centered with vertical margins | `\[\sum_{i=1}^n i = \frac{n(n+1)}{2}\]` |

---

## Basic Usage

Pass your string to the `content` property:

```dart
TeXWidget(
  content: r"""
    When \(a \ne 0\), the quadratic equation \(ax^2 + bx + c = 0\) has solutions:
    $$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$
    Another famous equation is \[E = mc^2\].
  """,
)
```

!!! tip "Notice the parameter is `content`"
    Remember to pass your text string to `content:`, not `math:`.

---

## Customizing Formulas & Text Appearance

You can customize the styling of text, inline equations, and display equations independently using builder callbacks:

```dart
TeXWidget(
  content: r"Given \(f(x) = x^2\), then $$\int_0^1 f(x) \, dx = \frac{1}{3}$$",
  
  // 1. Customize inline formulas (embedded within lines)
  inlineFormulaWidgetBuilder: (context, inlineFormula) {
    return Math2SVG(
      math: inlineFormula,
      formulaWidgetBuilder: (context, svg) => SvgPicture.string(
        svg,
        height: 18,
        colorFilter: const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
        fit: BoxFit.contain,
      ),
    );
  },

  // 2. Customize display block formulas (centered on their own line)
  displayFormulaWidgetBuilder: (context, displayFormula) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Math2SVG(
          math: displayFormula,
          formulaWidgetBuilder: (context, svg) => SvgPicture.string(
            svg,
            height: 48,
            colorFilter: const ColorFilter.mode(Colors.deepOrange, BlendMode.srcIn),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  },

  // 3. Customize the surrounding text
  textWidgetBuilder: (context, text) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  },
)
```

---

## When to Use `TeXWidget` vs `TeXView`

- **Use `TeXWidget`** when you have chat messages, blog paragraphs, or list items with equations. Because it uses pure Flutter rendering (`RichText` + `flutter_svg`), it renders smoothly in scrollable views and matches Flutter's native font scaler.
- **Use `TeXView`** when you need full HTML documents with CSS layouts, interactive quizzes, embedded videos, or JavaScript execution.

---

## API Reference

### Properties

| Property | Type | Default | Description |
|:---|:---|:---|:---|
| `content` | `String` | *required* | The text string containing plain text and delimited TeX formulas. |
| `inlineFormulaWidgetBuilder` | `Widget Function(BuildContext, String inlineFormula)?` | `null` | Custom builder for inline formulas (`$...$` and `\(...\)`). Receives the inner LaTeX string. |
| `displayFormulaWidgetBuilder` | `Widget Function(BuildContext, String displayFormula)?` | `null` | Custom builder for block display formulas (`$$...$$` and `\[...\]`). Receives the inner LaTeX string. |
| `textWidgetBuilder` | `InlineSpan Function(BuildContext, String text)?` | `null` | Custom builder for plain text segments. Receives the plain text string and returns an `InlineSpan` (e.g. `TextSpan`). |
