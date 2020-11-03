import 'dart:math' as math;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/app_chart.dart';
import '../../../cubits/editor/editor_cubit.dart';

class ChartViewer extends StatefulWidget {
  final AppChart appChart;

  ChartViewer({
    Key key,
    @required this.appChart,
  }) : super(key: key);

  @override
  _ChartViewerState createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  String randomViewId;

  final IFrameElement _iframeElement = IFrameElement();

  double iframeHeight = 1;

  bool chartInitiated = false;

  onMessageListener(event) {

    final data = (event as MessageEvent).data;
    // if data is: height newHeight
    if (data.startsWith('height')) {
      // Update iframe height
      final frData = (event as MessageEvent).data.split(' ');
      if (this.mounted) {
        setState(() {
          iframeHeight = double.tryParse(frData[1]);
        });
      }
    }
  }

  @override
  void initState() {
    final rand = math.Random();
    randomViewId = 'iframeElement' + rand.nextInt(100000).toString();

    final srcdoc = widget.appChart.getEmbedContent(
      withEditorScript: true,
    );

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
    final srcdoc = widget.appChart.getEmbedContent(
      withEditorScript: true,
    );
    _iframeElement.srcdoc = srcdoc;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Remove listener
    window.removeEventListener('message', onMessageListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: iframeHeight,
          child: HtmlElementView(
            key: Key('chartiframe'),
            viewType: randomViewId,
          ),
        ),
        if (iframeHeight == 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: CircularProgressIndicator(strokeWidth: 1),
          ),
      ],
    );
  }
}
