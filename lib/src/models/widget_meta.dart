enum Node { Root, InternalChild, InternalChildren, Leaf }

class TeXViewWidgetMeta {
  final String? id;
  final String? classList;
  final String? tag;
  final Node? node;

  const TeXViewWidgetMeta({this.id, this.classList, this.tag, this.node});

  Map toJson() => {
        'id': this.id,
        'classList': this.classList,
        'tag': this.tag,
        'node': _getNodeValue(this.node),
      };

  static String _getNodeValue(Node? node) {
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
