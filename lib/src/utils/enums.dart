enum LengthUnit { Pixels, Percent, Em }

/// TeX Rendering Engine, Katex for fast rendering, Mathjax for quality render.
enum RenderingEngine { MathJax, Katex }

class UnitHelper {
  static String getValue(LengthUnit unit) {
    switch (unit) {
      case LengthUnit.Pixels:
        return "px";
      case LengthUnit.Percent:
        return "%";
      case LengthUnit.Em:
        return "em";
      default:
        return "px";
    }
  }
}
