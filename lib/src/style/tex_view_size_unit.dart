enum TeXViewSizeUnit { Pixels, Percent, Em, Pt }

class UnitHelper {
  static String getValue(TeXViewSizeUnit unit) {
    switch (unit) {
      case TeXViewSizeUnit.Pixels:
        return "px";
        break;

      case TeXViewSizeUnit.Percent:
        return "%";
        break;

      case TeXViewSizeUnit.Em:
        return "em";
        break;

      case TeXViewSizeUnit.Pt:
        return "pt";
        break;

      default:
        return "px";
    }
  }
}
