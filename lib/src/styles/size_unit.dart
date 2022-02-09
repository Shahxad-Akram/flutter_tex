enum TeXViewSizeUnit { pixels, percent, em, pt }

class UnitHelper {
  static String getValue(TeXViewSizeUnit? unit) {
    switch (unit) {
      case TeXViewSizeUnit.pixels:
        return "px";

      case TeXViewSizeUnit.percent:
        return "%";

      case TeXViewSizeUnit.em:
        return "em";

      case TeXViewSizeUnit.pt:
        return "pt";

      default:
        return "px";
    }
  }
}
