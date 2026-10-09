"use strict";

window.tex_packages = (window.MathJax && window.MathJax.tex) ? window.MathJax.tex.packages : null;

function initTeXView(context, flutterTeXData, isWeb, iframeId = "") {
    let doc = context.document || document;
    let container = doc.getElementById('TeXView');
    if (!container) return;

    const parsedData = (typeof flutterTeXData === 'string')
        ? JSON.parse(flutterTeXData)
        : flutterTeXData;

    // Assemble the new DOM tree off-screen in a DocumentFragment to minimize reflows.
    const fragment = doc.createDocumentFragment();
    const view = createTeXViewBuilder(parsedData, container, iframeId, isWeb);

    view.addEventListener('click', (e) => handleDelegatedClick(e, iframeId, isWeb));

    fragment.appendChild(view);
    container.innerHTML = '';
    container.appendChild(fragment);

    const onComplete = () => {
        initResizeObserver(container, iframeId, isWeb);
    };

    if (isWeb && context.renderTeXView) {
        context.renderTeXView(onComplete);
    } else if (typeof renderTeXView === 'function') {
        renderTeXView(onComplete);
    } else {
        onComplete();
    }
}

function createTeXViewBuilder(rootData, teXViewElement, iframeId, isWeb) {
    const { meta, data, style } = rootData;

    const rippleEffect = rootData.rippleEffect;
    const { id, classList, tag, node } = meta;

    const element = document.createElement(tag);

    if (classList) element.className = classList;
    if (style) element.setAttribute('style', style);
    if (id) element.id = id;

    switch (node) {
        case 'root':
        case 'internal_child': {
            if (Array.isArray(data)) {
                data.forEach(child => {
                    element.appendChild(createTeXViewBuilder(child, teXViewElement, iframeId, isWeb));
                });
            } else {
                element.appendChild(createTeXViewBuilder(data, teXViewElement, iframeId, isWeb));
            }

            if (classList && classList.includes('tex-view-ink-well')) {

                if (rippleEffect) element.setAttribute('data-ripple', 'true');
            }
            break;
        }
        case 'leaf': {
            if (tag === 'img') {
                const src = (classList === 'tex-view-asset-image') ? '../../../' + data : data;
                element.setAttribute('src', src);
                element.addEventListener("load", () =>
                    reportHeight(teXViewElement, iframeId, isWeb)
                );
            } else {
                element.innerHTML = data;
            }
            break;
        }
        default: {
            if (Array.isArray(data)) {
                data.forEach(child => {
                    element.appendChild(createTeXViewBuilder(child, teXViewElement, iframeId, isWeb));
                });
            }
        }
    }
    return element;
}


function handleDelegatedClick(e, iframeId, isWeb) {
    const target = e.target.closest('.tex-view-ink-well');

    if (target) {
        const id = target.id;
        const rippleEffect = target.getAttribute('data-ripple') === 'true';

        if (isWeb) {
            if (typeof OnTapCallback === 'function') OnTapCallback(id, iframeId);
        } else {
            if (window.OnTapCallback) OnTapCallback.postMessage(id);
        }

        if (rippleEffect) {
            createRipple(e, target);
        }
    }
}

function createRipple(event, container) {
    const ripple = document.createElement('div');
    const d = Math.max(container.clientWidth, container.clientHeight);
    const rect = container.getBoundingClientRect();

    ripple.style.width = ripple.style.height = d + 'px';
    ripple.style.left = (event.clientX - rect.left - d / 2) + 'px';
    ripple.style.top = (event.clientY - rect.top - d / 2) + 'px';

    ripple.classList.add('ripple');

    ripple.addEventListener('animationend', () => ripple.remove());
    container.appendChild(ripple);
}

function debounceFrame(func) {
    let frameId;
    return function (...args) {
        const context = this;
        if (frameId) {
            cancelAnimationFrame(frameId);
        }
        frameId = requestAnimationFrame(() => {
            func.apply(context, args);
        });
    };
}

const debouncedReportHeight = debounceFrame((element, iframeId, isWeb) => {
    reportHeight(element, iframeId, isWeb);
});

function initResizeObserver(element, iframeId, isWeb) {
    reportHeight(element, iframeId, isWeb);

    if (window.ResizeObserver) {
        const observer = new ResizeObserver(() => {
            debouncedReportHeight(element, iframeId, isWeb);
        });
        observer.observe(element);
    }
}

function reportHeight(element, iframeId, isWeb) {
    const height = getTeXViewHeight(element);

    if (isWeb) {
        if (typeof OnTeXViewRenderedCallback === 'function') {
            OnTeXViewRenderedCallback(height, iframeId);
        }
    } else {
        if (window.OnTeXViewRenderedCallback) {
            OnTeXViewRenderedCallback.postMessage(height);
        }
    }
}

function getTeXViewHeight(view) {
    const style = window.getComputedStyle(view);
    const marginTop = parseInt(style.marginTop) || 0;
    const marginBottom = parseInt(style.marginBottom) || 0;
    return view.offsetHeight + marginTop + marginBottom;
}