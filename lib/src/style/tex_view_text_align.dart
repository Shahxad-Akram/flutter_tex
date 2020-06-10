enum TeXViewTextAlign { Center, Left, Right, Justify }

class TeXViewTextAlignHelper {
  static String getValue(TeXViewTextAlign teXViewTextAlign) {
    switch (teXViewTextAlign) {
      case TeXViewTextAlign.Center:
        return "center";
        break;

      case TeXViewTextAlign.Left:
        return "left";
        break;

      case TeXViewTextAlign.Right:
        return "right";
        break;

      case TeXViewTextAlign.Justify:
        return "justify";
        break;

      default:
        return "left";
    }
  }
}
