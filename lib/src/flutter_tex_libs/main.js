const teXViewServerPort = getUrlParam('teXViewServerPort');

function initTeXView() {
    const requestUrl = `http://localhost:${teXViewServerPort}/?query=getRawTeXHTML`;
    const httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', requestUrl);
    httpRequest.send();
    httpRequest.onload = () => {
        let rawTeXHTML = JSON.parse(httpRequest.responseText);
        teXView.setAttribute('style', rawTeXHTML['style']);
        rawTeXHTML['children'].forEach((child) => {
            let teXViewChild = document.createElement('div');
            teXViewChild.setAttribute("style", child['decoration']['style']);
            teXViewChild.classList.add("tex-view-child");

            teXViewChild.appendChild(spawnElement(child['decoration']['titleStyle'], child['title']))
            teXViewChild.appendChild(spawnElement(child['decoration']['bodyStyle'], child['body']));

            let childID = child['id'];
            if (childID != null) {
                teXViewChild.addEventListener('click', function (e) {
                    TeXViewChildTapCallback.postMessage(childID);
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
            teXView.appendChild(teXViewChild)
        });
        onTeXViewRenderComplete();
    }
}

function spawnElement(style, data) {
    let teXViewElement = document.createElement('div');
    teXViewElement.setAttribute("style", style);
    teXViewElement.innerHTML = data;
    return teXViewElement;
}

function getUrlParam(param) {
    return decodeURIComponent(new URLSearchParams(window.location.search).get(param));
}