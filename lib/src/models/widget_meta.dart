enum Node { root, internalChild, internalChildren, leaf }

class TeXViewWidgetMeta {
  final String? id;
  final String? classList;
  final String? tag;
  final Node? node;

  const TeXViewWidgetMeta({this.id, this.classList, this.tag, this.node});

  Map toJson() => {
        'id': id,
        'classList': classList,
        'tag': tag,
        'node': _getNodeValue(node),
      };

  static String _getNodeValue(Node? node) {
    switch (node) {
      case Node.root:
        return "root";
      case Node.internalChild:
        return "internal_child";
      case Node.internalChildren:
        return "internal_children";
      case Node.leaf:
        return "leaf";
      default:
        return "leaf";
    }
  }
}
