enum TeXViewTextAlign { Center, Left, Right, Justify }

class TeXViewTextAlignHelper {
  static String getValue(TeXViewTextAlign? teXViewTextAlign) {
    switch (teXViewTextAlign) {
      case TeXViewTextAlign.Center:
        return "center";

      case TeXViewTextAlign.Left:
        return "left";

      case TeXViewTextAlign.Right:
        return "right";

      case TeXViewTextAlign.Justify:
        return "justify";

      default:
        return "left";
    }
  }
}
