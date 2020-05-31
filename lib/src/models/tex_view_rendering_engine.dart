import 'dart:convert';

class TeXViewRenderingEngine {
  final String configurations;
  final String _engineName;

  const TeXViewRenderingEngine.katex({this.configurations})
      : this._engineName = "katex";

  const TeXViewRenderingEngine.mathjax()
      : this._engineName = "mathjax",
        configurations = null;

  String getConfigurations() {
    return json.encode(configurations ?? "{}");
  }

  String getEngineName() {
    return this._engineName;
  }
}
