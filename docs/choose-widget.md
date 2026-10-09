# Which Widget Should You Use?

`flutter_tex` gives you three widgets depending on whether you need a single formula, a mixed text paragraph, or a rich HTML document:

```
                      What do you want to render?
                                   |
         -----------------------------------------------------
         |                                                   |
  Single formula only?                             Mixed content / Document?
         |                                                   |
    [Math2SVG]                             -------------------------------------
  • Pure Flutter (no WebView)              |                                   |
  • SVG output via flutter_svg     Inline math in a paragraph?       Full HTML / Markdown / Quiz?
  • Fast, lightweight                      |                                   |
  • Great in lists                    [TeXWidget]                          [TeXView]
                                   • Pure Flutter (SVG + RichText)     • WebView / iframe
                                   • Auto-parses $...$ and $$...$$     • Rich CSS, JS, taps
                                   • Fast, responsive                  • Heavy; avoid in long lists
```

## Feature Comparison

| Feature | `Math2SVG` | `TeXWidget` | `TeXView` |
|:---|:---|:---|:---|
| **Underlying Engine** | Pure Flutter (`flutter_svg`) | Pure Flutter (`flutter_svg` + `RichText`) | WebView (Mobile/macOS) / `iframe` (Web) |
| **Best For** | Standalone formulas, equation items | Sentences and paragraphs with math | Full articles, quiz questions, HTML/JS |
| **Input Formats** | LaTeX, MathML, AsciiMath | LaTeX mixed with plain text | HTML with TeX, Markdown, Media |
| **List Performance** | High (cached SVGs, fast scrolling) | High (cached SVGs, fast scrolling) | Heavy (do not spawn dozens in a `ListView`) |
| **Custom Styling** | `formulaWidgetBuilder` (colors, size) | Builders for inline, display, and text | `TeXViewStyle` & custom CSS |
| **Interactivity** | Standard Flutter gestures (`GestureDetector`) | Standard Flutter gestures | `TeXViewInkWell` tap callbacks & ripples |

---