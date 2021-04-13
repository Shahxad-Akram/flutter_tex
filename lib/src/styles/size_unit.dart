enum TeXViewSizeUnit { Pixels, Percent, Em, Pt }

class UnitHelper {
  static String getValue(TeXViewSizeUnit? unit) {
    switch (unit) {
      case TeXViewSizeUnit.Pixels:
        return "px";

      case TeXViewSizeUnit.Percent:
        return "%";

      case TeXViewSizeUnit.Em:
        return "em";

      case TeXViewSizeUnit.Pt:
        return "pt";

      default:
        return "px";
    }
  }
}
