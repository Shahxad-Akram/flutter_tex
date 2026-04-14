// Enable strict mode for better error handling
"use strict";

// Retrieve TeX packages from MathJax if available
window.tex_packages = (window.MathJax && window.MathJax.tex) ? window.MathJax.tex.packages : null;

// Unified function to initialize the TeXView (Supports both Web and Mobile)
function initTeXView(context, flutterTeXData, isWeb, iframeId = "") {
    // Determine the correct document root
    let doc = context.document || document;
    let container = doc.getElementById('TeXView');

    if (!container) return;

    container.innerHTML = '';

    const parsedData = (typeof flutterTeXData === 'string')
        ? JSON.parse(flutterTeXData)
        : flutterTeXData;

    const view = createTeXViewBuilder(parsedData, container, iframeId, isWeb);

    // OPTIMIZATION: Event Delegation
    // Instead of attaching a click listener to every interactive element,
    // we attach a single listener to the root view.
    view.addEventListener('click', (e) => handleDelegatedClick(e, iframeId, isWeb));

    container.appendChild(view);

    const onComplete = () => {
        initResizeObserver(container, iframeId, isWeb);
    };

    // Render logic (MathJax)
    if (isWeb && context.renderTeXView) {
        context.renderTeXView(onComplete);
    } else if (typeof renderTeXView === 'function') {
        renderTeXView(onComplete);
    } else {
        onComplete();
    }
}

// Function to create a TeX view builder recursively
function createTeXViewBuilder(rootData, teXViewElement, iframeId, isWeb) {
    const { meta, data, style } = rootData;
    // FIX: rippleEffect comes from rootData, NOT meta
    const rippleEffect = rootData.rippleEffect;
    const { id, classList, tag, node } = meta;

    const element = document.createElement(tag);

    // FIX: Use className to support multiple classes (e.g. "tex-view-ink-well other-class")
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

            // FIX: Check for the class and pass the correctly extracted rippleEffect
            if (classList && classList.includes('tex-view-ink-well')) {
                // OPTIMIZATION: Removed individual click listener (clickManager).
                // We now use data attributes for the delegated handler.
                if (rippleEffect) element.setAttribute('data-ripple', 'true');
            }
            break;
        }
        case 'leaf': {
            if (tag === 'img') {
                const src = (classList === 'tex-view-asset-image') ? '../../../' + data : data;
                element.setAttribute('src', src);
                // Optional: Trigger resize on image load
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

// OPTIMIZATION: Delegated Click Handler
// Handles clicks for all 'tex-view-ink-well' elements efficiently.
function handleDelegatedClick(e, iframeId, isWeb) {
    const target = e.target.closest('.tex-view-ink-well');

    if (target) {
        const id = target.id;
        const rippleEffect = target.getAttribute('data-ripple') === 'true';

        // Report click to Flutter
        if (isWeb) {
            if (typeof OnTapCallback === 'function') OnTapCallback(id, iframeId);
        } else {
            if (window.OnTapCallback) OnTapCallback.postMessage(id);
        }

        // Handle Ripple
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

function debounce(func, wait) {
    let timeout;
    return function (...args) {
        const context = this;
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(context, args), wait);
    };
}

const debouncedReportHeight = debounce((element, iframeId, isWeb) => {
    reportHeight(element, iframeId, isWeb);
}, 100);

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