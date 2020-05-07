import 'dart:convert';

class TeXViewRenderingEngine {
  final String configurations;
  String _engineName;

  TeXViewRenderingEngine.katex({this.configurations}) {
    this._engineName = "katex";
  }

  TeXViewRenderingEngine.mathjax() : configurations = null {
    this._engineName = "mathjax";
  }

  String getConfigurations() {
    return json.encode(configurations ?? "{}");
  }

  String getEngineName() {
    return this._engineName;
  }
}
