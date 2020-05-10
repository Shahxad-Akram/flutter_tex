"use strict";
var teXViewServerPort = getUrlParam('teXViewServerPort');
var urlRawTeXHTML = getUrlParam('urlRawTeXHTML');
var configurations = JSON.parse(getUrlParam('configurations'));

function initTeXView() {
    if (urlRawTeXHTML == null) {
        console.log('From Request source');
        var httpRequest = new XMLHttpRequest();
        httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState === 4 && httpRequest.status === 200)
                createView(httpRequest.responseText);
        }
        httpRequest.open('GET', "http://localhost:" + teXViewServerPort + "/?query=getRawTeXHTML");
        httpRequest.send();
    } else {
        console.log('From Url source');
        createView(urlRawTeXHTML);
    }
}


function createView(teXViewData) {
    var rawTeXHTML = JSON.parse(teXViewData);
    teXView.setAttribute('style', rawTeXHTML['style']);
    rawTeXHTML['children'].forEach(function (teXViewContainerData) {
        var teXViewContainerElement = spawnElement("tex-view-container", teXViewContainerData['style']);
        teXViewContainerData['children'].forEach(function (teXViewTeXData) {
            var teXViewTeXElement = spawnElement("tex-view-tex", teXViewTeXData['style']);
            rippleManager(teXViewTeXElement, teXViewTeXData['id']);
            teXViewTeXElement.innerHTML = teXViewTeXData['data'];
            teXViewContainerElement.appendChild(teXViewTeXElement);
        });
        rippleManager(teXViewContainerElement, teXViewContainerData['id']);
        teXView.appendChild(teXViewContainerElement)
    });
    onTeXViewRenderComplete();

}

function spawnElement(className, style) {
    var teXViewContainerElement = document.createElement('div');
    teXViewContainerElement.classList.add(className);
    teXViewContainerElement.setAttribute("style", style);
    return teXViewContainerElement;
}

function rippleManager(element, id) {
    if (id != null) {
        element.addEventListener('click', function (e) {
            TeXViewChildTapCallback.postMessage(id);
            var ripple = document.createElement('div');
            this.appendChild(ripple);
            var d = Math.max(this.clientWidth, this.clientHeight);
            ripple.style.width = ripple.style.height = d + 'px';
            var rect = this.getBoundingClientRect();
            ripple.style.left = e.clientX - rect.left - d / 2 + 'px';
            ripple.style.top = e.clientY - rect.top - d / 2 + 'px';
            ripple.classList.add('ripple');
        });
    }
}


function getUrlParam(name) {
    var url = decodeURI(location.href);
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(url);
    return results == null ? null : results[1];
}

function getTeXViewHeight(element) {
    var height = element.offsetHeight,
        style = window.getComputedStyle(element)
    return ['top', 'bottom']
        .map(function (side) {
            return parseInt(style["margin-" + side]);
        })
        .reduce(function (total, side) {
            return total + side;
        }, height)
}

/*


function webSocketClient() {
    var exampleSocket = new WebSocket("ws://localhost:" + (teXViewServerPort * 10).toString() + "");
    exampleSocket.onopen = function (event) {
        exampleSocket.send("Here's some text that the server is urgently awaiting!");
    };
    exampleSocket.onclose = function (e) {
        console.log("closssssssssssssssssssssssssssssssssssed");
    }
    exampleSocket.onmessage = function (event) {
        console.log(event.data);
    }
}
*/
