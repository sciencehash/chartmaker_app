(function () {
    // Chart ID in the HTML element
    var chartId = '';

    // Chart library name
    var lib = '';

    // on load listener
    window.addEventListener('load', function (event) {
        // Get script element
        let scriptElement = document.getElementById('editorscript');
        // Get chart library name
        lib = scriptElement.getAttribute('lib');
        // Get chart ID in the HTML element
        chartId = scriptElement.getAttribute('chartId');
        // Get canvas or div element
        let chartElement = document.getElementById(chartId);
        // chartElement has 'height' for canvas and has 'clientHeight' for div
        let height = chartElement.height || chartElement.clientHeight;
        // Report new height
        window.top.postMessage(`height ${height + 20}`, '*');
    });

    // On resize listener
    window.addEventListener('resize', function (event) {
        if (chartId !== '') {
            // Get canvas or div element
            let chartElement = document.getElementById(chartId);
            // chartElement has 'height' for canvas and has 'clientHeight' for div
            let height = chartElement.height || chartElement.clientHeight;
            // Report new height
            window.top.postMessage(`height ${height + 20}`, '*');
        }
    });

    //
    window.addEventListener('message', function (event) {
        if (event.data === 'getBase64ImageURI') {
            if (lib === 'chartjs') {
                // Get chart as PNG
                base64ImageURI = chartjs.toBase64Image();
                // Return PNG data
                window.top.postMessage(`base64ImageURI${base64ImageURI}`, '*');
            } else if (lib === 'apexcharts') {
                // Waiting to starting animation ending
                window.setTimeout(function () {
                    // Get chart as PNG
                    apexchart.dataURI().then((uri) => {
                        // Return PNG data
                        window.top.postMessage(`base64ImageURI${uri.imgURI}`, '*');
                    });
                }, 1000);
            }
        }
    });
})();
