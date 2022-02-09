enum TeXViewTextAlign { center, left, right, justify }

class TeXViewTextAlignHelper {
  static String getValue(TeXViewTextAlign? teXViewTextAlign) {
    switch (teXViewTextAlign) {
      case TeXViewTextAlign.center:
        return "center";

      case TeXViewTextAlign.left:
        return "left";

      case TeXViewTextAlign.right:
        return "right";

      case TeXViewTextAlign.justify:
        return "justify";

      default:
        return "left";
    }
  }
}
