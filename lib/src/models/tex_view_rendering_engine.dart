import 'dart:convert';

class Configurations {
  static const String mathjaxDefaultConfiguration = """
  {
      showMathMenu: false,
      delayStartupUntil: "configured",
      tex2jax: {
          ignoreClass: "tex2jax_ignore",
      },
      jax: ["input/TeX", "output/SVG"],
      extensions: ["tex2jax.js", "MathEvents.js"],
      TeX: {
          extensions: ["mhchem.js", "noErrors.js", "noUndefined.js", "autoload-all.js"],
          noErrors: {disabled: true}
      },
      MathMenu: {
          showRenderer: false
      },
      messageStyle: "none",
      SVG: {
          blacker: 0,
          font: "Gyre-Pagella",
          linebreaks: {
              automatic: true,
              width: "container"
          },
          scale: 90,
          useFontCache: true,
          useGlobalCache: true,
          matchFontHeight: true
      }
  }
  """;
}

class TeXViewRenderingEngine {
  static String dd = "dfd";
  final String configurations;

  final String name;

  const TeXViewRenderingEngine.katex({this.configurations})
      : this.name = "katex";

  const TeXViewRenderingEngine.mathjax(
      {this.configurations = Configurations.mathjaxDefaultConfiguration})
      : this.name = "mathjax";

  String getConfigurations() {
    return json.encode(configurations ?? "{}");
  }
}
