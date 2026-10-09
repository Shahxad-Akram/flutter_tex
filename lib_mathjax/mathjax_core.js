// Import necessary MathJax components and modules
import { startup } from '@mathjax/src/components/js/startup/init.js';
import { Loader } from '@mathjax/src/js/components/loader.js';

// Import core MathJax components
import '@mathjax/src/components/js/core/core.js';
// Input modules for different formats
import '@mathjax/src/components/js/input/tex/tex.js';
import '@mathjax/src/components/js/input/mml/mml.js';
import '@mathjax/src/components/js/input/asciimath/asciimath.js';
// TeX Extensions for additional functionalities
import '@mathjax/src/components/js/input/tex/extensions/action/action.js';
import '@mathjax/src/components/js/input/tex/extensions/amscd/amscd.js';
import '@mathjax/src/components/js/input/tex/extensions/bbm/bbm.js';
import '@mathjax/src/components/js/input/tex/extensions/bboldx/bboldx.js';
import '@mathjax/src/components/js/input/tex/extensions/bbox/bbox.js';
import '@mathjax/src/components/js/input/tex/extensions/begingroup/begingroup.js';
import '@mathjax/src/components/js/input/tex/extensions/boldsymbol/boldsymbol.js';
import '@mathjax/src/components/js/input/tex/extensions/braket/braket.js';
import '@mathjax/src/components/js/input/tex/extensions/bussproofs/bussproofs.js';
import '@mathjax/src/components/js/input/tex/extensions/cancel/cancel.js';
import '@mathjax/src/components/js/input/tex/extensions/cases/cases.js';
import '@mathjax/src/components/js/input/tex/extensions/centernot/centernot.js';
import '@mathjax/src/components/js/input/tex/extensions/color/color.js';
import '@mathjax/src/components/js/input/tex/extensions/colortbl/colortbl.js';
import '@mathjax/src/components/js/input/tex/extensions/colorv2/colorv2.js';
import '@mathjax/src/components/js/input/tex/extensions/dsfont/dsfont.js';
import '@mathjax/src/components/js/input/tex/extensions/empheq/empheq.js';
import '@mathjax/src/components/js/input/tex/extensions/enclose/enclose.js';
import '@mathjax/src/components/js/input/tex/extensions/extpfeil/extpfeil.js';
import '@mathjax/src/components/js/input/tex/extensions/gensymb/gensymb.js';
import '@mathjax/src/components/js/input/tex/extensions/html/html.js';
import '@mathjax/src/components/js/input/tex/extensions/mathtools/mathtools.js';
import '@mathjax/src/components/js/input/tex/extensions/mhchem/mhchem.js';
import '@mathjax/src/components/js/input/tex/extensions/noerrors/noerrors.js';
import '@mathjax/src/components/js/input/tex/extensions/physics/physics.js';
import '@mathjax/src/components/js/input/tex/extensions/setoptions/setoptions.js';
import '@mathjax/src/components/js/input/tex/extensions/tagformat/tagformat.js';
import '@mathjax/src/components/js/input/tex/extensions/texhtml/texhtml.js';
import '@mathjax/src/components/js/input/tex/extensions/textcomp/textcomp.js';
import '@mathjax/src/components/js/input/tex/extensions/unicode/unicode.js';
import '@mathjax/src/components/js/input/tex/extensions/units/units.js';
import '@mathjax/src/components/js/input/tex/extensions/upgreek/upgreek.js';
import '@mathjax/src/components/js/input/tex/extensions/verb/verb.js';
// Output module for SVG rendering
import { loadFont } from '@mathjax/src/components/js/output/svg/svg.js';

// Preload necessary components for MathJax
Loader.preLoaded(
  'loader',
  'startup',
  'core',
  'input/tex',
  'input/mml',
  'input/asciimath',
  'output/svg',
);

Loader.saveVersion('mathjax_core.js');
loadFont(startup, true);

import '@mathjax/mathjax-mhchem-font-extension/svg.js';

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

import { mathjax } from '@mathjax/src/js/mathjax.js';
import { liteAdaptor } from '@mathjax/src/js/adaptors/liteAdaptor.js';
import { RegisterHTMLHandler } from '@mathjax/src/js/handlers/html.js';
import { TeX } from '@mathjax/src/js/input/tex.js';
import { MathML } from '@mathjax/src/js/input/mathml.js';
import { AsciiMath } from '@mathjax/src/js/input/asciimath.js';
import { SVG } from '@mathjax/src/js/output/svg.js';

const DEFAULT_TEX_PACKAGES = ['base', 'ams', 'textmacros'];

class FlutterTeXLiteDOM {
  constructor() {
    this.options = {};
    this.adaptor = liteAdaptor();
    RegisterHTMLHandler(this.adaptor);
    this.outputJax = new SVG();
    this.docs = new Map();
  }

  #createDoc(Type, isTeX = false) {
    let inputJax;

    if (isTeX) {
      const externalPackages = (typeof window.tex_packages !== 'undefined' && window.tex_packages !== null)
        ? window.tex_packages
        : [];

      inputJax = new TeX({
        ...this.options,
        packages: [...DEFAULT_TEX_PACKAGES, ...externalPackages].filter(p => typeof p === 'string')
      });
    } else {
      inputJax = new Type(this.options);
    }

    return mathjax.document('', {
      InputJax: inputJax,
      OutputJax: this.outputJax
    });
  }

  math2SVG(math, inputType = 'teX', options = {}) {
    try {
      const content = math || '';
      const doc = this.#getJaxDoc(inputType);

      const node = doc.convert(content, options);
      const svg = this.adaptor.innerHTML(node);

      doc.clear();

      return svg;
    } catch (e) {
      console.error(`Error in math2SVG (${inputType}):`, e);
      return '';
    }
  }

  #getJaxDoc(input) {
    if (this.docs.has(input)) return this.docs.get(input);

    let doc;
    switch (input) {
      case 'mathML':
        doc = this.#createDoc(MathML);
        break;
      case 'asciiMath':
        doc = this.#createDoc(AsciiMath);
        break;
      case 'teX':
      default:
        doc = this.#createDoc(TeX, true);
        break;
    }

    this.docs.set(input, doc);
    return doc;
  }
}

const flutterTeXLiteDOM = new FlutterTeXLiteDOM();

// Attach to window
window.MathJax = window.MathJax || {};
window.MathJax.flutterTeXLiteDOM = flutterTeXLiteDOM;