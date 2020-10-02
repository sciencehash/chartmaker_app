import 'dart:math' as math;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

// import 'dart:ui' as ui;
import 'package:chartmaker_app/cubits/editor/editor_cubit.dart';
import 'package:chartmaker_app/widgets/editors/utils/EditorUtils.dart';

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

    final srcdoc = EditorUtils.getEmbedContent(
      lib: widget.lib,
      config: widget.config,
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
    final srcdoc = EditorUtils.getEmbedContent(
      lib: widget.lib,
      config: widget.config,
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
