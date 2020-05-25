enum Node { Root, InternalChild, InternalChildren, Leaf }

class TeXViewWidgetMeta {
  final String type;
  final String tag;
  final Node node;

  const TeXViewWidgetMeta({this.type, this.tag, this.node});

  Map toJson() => {
        'type': this.type,
        'tag': this.tag,
        'node': _getNodeValue(this.node),
      };

  static String _getNodeValue(Node node) {
    switch (node) {
      case Node.Root:
        return "root";
      case Node.InternalChild:
        return "internal_child";
      case Node.InternalChildren:
        return "internal_children";
      case Node.Leaf:
        return "leaf";
      default:
        return "leaf";
    }
  }
}
