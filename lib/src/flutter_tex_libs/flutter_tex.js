const teXViewServerPort = getUrlParam('teXViewServerPort');
const configurations = JSON.parse(getUrlParam('configurations'));


function initTeXView() {
    const requestUrl = `http://localhost:${teXViewServerPort}/?query=getRawTeXHTML`;
    const httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', requestUrl);
    httpRequest.send();
    httpRequest.onload = () => {

        let rawTeXHTML = JSON.parse(httpRequest.responseText);
        teXView.setAttribute('style', rawTeXHTML['style']);

        rawTeXHTML['children'].forEach((teXViewContainerData) => {
            let teXViewContainerElement = spawnElement("tex-view-container", teXViewContainerData['style']);
            teXViewContainerData['children'].forEach((teXViewTeXData) => {
                let teXViewTeXElement = spawnElement("tex-view-tex", teXViewTeXData['style']);
                teXViewTeXElement.innerHTML = teXViewTeXData['data'];
                rippleManager(teXViewTeXElement, teXViewTeXData['id']);
                teXViewContainerElement.appendChild(teXViewTeXElement);
            });
            rippleManager(teXViewContainerElement, teXViewContainerData['id']);
            teXView.appendChild(teXViewContainerElement)
        });
        onTeXViewRenderComplete();
    }
}

function spawnElement(className, style) {
    let teXViewContainerElement = document.createElement('div');
    teXViewContainerElement.classList.add(className);
    teXViewContainerElement.setAttribute("style", style);
    return teXViewContainerElement;
}

function rippleManager(element, id) {
    if (id != null) {
        element.addEventListener('click', function (e) {
            TeXViewChildTapCallback.postMessage(id);
            let ripple = document.createElement('div');
            this.appendChild(ripple);
            let d = Math.max(this.clientWidth, this.clientHeight);
            ripple.style.width = ripple.style.height = d + 'px';
            let rect = this.getBoundingClientRect();
            ripple.style.left = e.clientX - rect.left - d / 2 + 'px';
            ripple.style.top = e.clientY - rect.top - d / 2 + 'px';
            ripple.classList.add('ripple');
        });
    }
}

function getUrlParam(param) {
    return decodeURIComponent(new URLSearchParams(window.location.search).get(param));
}