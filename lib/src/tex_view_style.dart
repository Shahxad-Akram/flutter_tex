class TeXViewStyle {
  String style;
  String titleStyle;
  String bodyStyle;

  TeXViewStyle({this.style, this.titleStyle, this.bodyStyle});

  Map<dynamic, dynamic> toJson() => {
        'style': (style ?? "").replaceAll("%", "%25"),
        'titleStyle': (titleStyle ?? "").replaceAll("%", "%25"),
        'bodyStyle': (bodyStyle ?? "").replaceAll("%", "%25"),
      };
}
