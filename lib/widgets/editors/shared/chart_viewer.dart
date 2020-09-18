import 'dart:math' as math;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

// import 'dart:ui' as ui;
import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ChartViewer extends StatefulWidget {
  final Map config;

  ChartViewer({Key key, @required this.config}) : super(key: key);

  @override
  _ChartViewerState createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  String randomViewId;

  final IFrameElement _iframeElement = IFrameElement();

  double iframeHeight = 500;

  bool chartInitiated = false;

  @override
  void initState() {
    final rand = math.Random();
    randomViewId = 'iframeElement' + rand.nextInt(100000).toString();

    ui.platformViewRegistry.registerViewFactory(
      randomViewId,
      (int randomViewId) {
        _iframeElement.style.border = 'none';
        _iframeElement.srcdoc =
            '''<canvas id="chart"></canvas><script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script><script defer src="viewer.js"></script>''';
        return _iframeElement;
      },
    );

    window.addEventListener('message', (event) {
      if ((event as MessageEvent).data != "rid") {
        // Update iframe height
        final frData = (event as MessageEvent).data.split(' ');
        setState(() {
          iframeHeight = double.tryParse(frData[1]);
        });
      }
      if ((event as MessageEvent).data == "rid") {
        // print((event as MessageEvent).data);
        if (_iframeElement.contentWindow != null) {
          // Send initial data, iframe ID and chart configuration
          _iframeElement.contentWindow.postMessage(
            'viewerIframeID ${Utils.chartConfigToBase64(widget.config)}',
            '*',
          );
        }
      }
    });

    window.addEventListener('resize', (event) {
      if (_iframeElement.contentWindow != null) {
        // Send initial data, iframe ID and chart configuration
        _iframeElement.contentWindow.postMessage(
          'viewerIframeID ${Utils.chartConfigToBase64(widget.config)}',
          '*',
        );
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(ChartViewer oldWidget) {
    //
    _iframeElement.contentWindow.postMessage(
      'viewerIframeID ${Utils.chartConfigToBase64(widget.config)}',
      '*',
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: iframeHeight,
      child: HtmlElementView(
        key: Key('chartiframe'),
        viewType: randomViewId,
      ),
    );
  }
}
