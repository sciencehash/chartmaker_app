import 'dart:math' as math;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

// import 'dart:ui' as ui;
import 'package:chartmaker_app/cubits/editor/editor_cubit.dart';

import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class ChartViewer extends StatefulWidget {
  final String lib;
  final Map config;

  ChartViewer({
    Key key,
    @required this.lib,
    @required this.config,
  }) : super(key: key);

  @override
  _ChartViewerState createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  String randomViewId;

  final IFrameElement _iframeElement = IFrameElement();

  double iframeHeight = 500;

  bool chartInitiated = false;

  onMessageListener(event) {
    final data = (event as MessageEvent).data;
    // if data is: frameId newHeight
    if (data != 'rid' && !data.startsWith('base64ImageURI')) {
      // Update iframe height
      final frData = (event as MessageEvent).data.split(' ');
      if (this.mounted) {
        setState(() {
          iframeHeight = double.tryParse(frData[1]);
        });
      }
    }
    // rid: Request initial data, to send iframe ID and chart configuration
    if (data == 'rid') {
      // print((event as MessageEvent).data);
      if (_iframeElement.contentWindow != null) {
        // Send initial data, iframe ID and chart configuration
        _iframeElement.contentWindow.postMessage(
          'viewerIframeID ${Utils.chartConfigToBase64({
            'lib': widget.lib,
            'config': widget.config,
          })}',
          '*',
        );
      }
    }
  }

  onResizeListener(event) {
    if (_iframeElement.contentWindow != null) {
      // Send initial data, iframe ID and chart configuration
      _iframeElement.contentWindow.postMessage(
        'viewerIframeID ${Utils.chartConfigToBase64({
          'lib': widget.lib,
          'config': widget.config,
        })}',
        '*',
      );
    }
  }

  @override
  void initState() {
    final rand = math.Random();
    randomViewId = 'iframeElement' + rand.nextInt(100000).toString();

    final srcdoc = widget.lib == 'chartjs'
        ? '''<canvas id="chart"></canvas><script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script><script src="chartmaker.min.js"></script>'''
        : '''<div id="chart"></div><script src="https://cdn.jsdelivr.net/npm/apexcharts"></script><script src="chartmaker.min.js"></script>''';

    ui.platformViewRegistry.registerViewFactory(
      randomViewId,
      (int randomViewId) {
        _iframeElement.style.border = 'none';
        _iframeElement.srcdoc = srcdoc;
        return _iframeElement;
      },
    );

    // Add listener
    window.addEventListener('message', onMessageListener);
    // Add listener
    window.addEventListener('resize', onResizeListener);

    //
    context.bloc<EditorCubit>().setCurrentWindowAndIFrame(
          window,
          _iframeElement,
        );

    super.initState();
  }

  @override
  void didUpdateWidget(ChartViewer oldWidget) {
    //
    _iframeElement.contentWindow.postMessage(
      'viewerIframeID ${Utils.chartConfigToBase64({
        'lib': widget.lib,
        'config': widget.config,
      })}',
      '*',
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Remove listener
    window.removeEventListener('message', onMessageListener);
    // Remove listener
    window.removeEventListener('resize', onResizeListener);

    super.dispose();
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
