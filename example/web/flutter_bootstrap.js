{{flutter_js}}
{{flutter_build_config}}

const searchParams = new URLSearchParams(window.location.search);

_flutter.loader.load({
    config: {
        'renderer': 'canvaskit'
    },
});