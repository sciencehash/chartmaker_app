import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/editor/editor_cubit.dart';
import '../../../models/app_chart.dart';

class EmbedContent extends StatelessWidget {
  String _lib;
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    //
    AppChart appChart =
        (context.bloc<EditorCubit>().state as EditorLoaded).appChart;
    //
    _lib = appChart.config['lib'];

    //
    math.Random rand = math.Random();
    final String iFrameId = 'iFrame${rand.nextInt(99999)}';

    //
    if (_lib == 'chartjs') {
      //
      _textController.text = r'''<iframe id="''';
      _textController.text += iFrameId;
      _textController.text += r'''" width="100%" style="border:none" scrolling="no" srcdoc="''';
      _textController.text += r'''&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js&quot; integrity=&quot;sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==&quot; crossorigin=&quot;anonymous&quot;&gt;&lt;/script&gt;''';
      _textController.text += r'''&lt;script defer src=&quot;https://web.chartmaker.org/chartmaker.min.js&quot;&gt;&lt;/script&gt;''';
      _textController.text += r'''&lt;canvas id=&quot;chart&quot;&gt;&lt;/canvas&gt;"></iframe>''';
    } else if (_lib == 'apexcharts') {
      _textController.text = r'''<iframe id="''';
      _textController.text += iFrameId;
      _textController.text += r'''" width="100%" style="border:none" scrolling="no" srcdoc="''';
      _textController.text += r'''&lt;div id=&quot;chart&quot;&gt;&lt;/div&gt;''';
      _textController.text += r'''&lt;script src=&quot;https://cdn.jsdelivr.net/npm/apexcharts&quot;&gt;&lt;/script&gt;''';
      _textController.text += r'''&lt;script src=&quot;https://web.chartmaker.org/chartmaker.min.js&quot;&gt;&lt;/script&gt;''';
    }

    //
    var b64codec = Base64Codec();
    var encodedTestChartJsConfig = b64codec.encode(
      json.encode(appChart.config).codeUnits,
    );
    //
    final String chartConfig = encodedTestChartJsConfig;

    //
    _textController.text += r'''<script>if("undefined"==typeof chartMakerGlobalListener){var chartMakerGlobalListener=!0;window.addEventListener("message",function(a){if("rid"!==a.data){let b=a.data.split(" ");document.getElementById(b[0]).style=`height:${b[1]}px; border:none;background: #f5f5f5;`}})}if("undefined"==typeof chartMakerInitiatedCharts)var chartMakerInitiatedCharts=[];window.addEventListener("message",function(a){"rid"!==a.data||chartMakerInitiatedCharts.includes("''';
    _textController.text += iFrameId;
    _textController.text += r'''")||(document.getElementById("''';
    _textController.text += iFrameId;
    _textController.text += r'''").contentWindow.postMessage("''';
    _textController.text += iFrameId;
    _textController.text += r''' ''';
    _textController.text += chartConfig;
    _textController.text += r'''","*"),chartMakerInitiatedCharts.push("''';
    _textController.text += iFrameId;
    _textController.text += r'''"))});</script>''';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: Text('Embed'),
          backgroundColor: Colors.transparent,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Copy the next text in your website:'),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white.withOpacity(.1),
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
            enableInteractiveSelection: true,
            maxLines: 5,
            readOnly: true,
          ),
          // child: SelectableText(
          //   '''<iframe id="iframe123456" width="100%" style="border:none" scrolling="no" srcdoc="&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js&quot; integrity=&quot;sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==&quot; crossorigin=&quot;anonymous&quot;&gt;&lt;/script&gt;&lt;script defer src=&quot;../dist/chartmaker.min.js&quot;&gt;&lt;/script&gt;&lt;canvas id=&quot;chart&quot;&gt;&lt;/canvas&gt;"></iframe>
          //       <script></script>''',
          // ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FlatButton(
            child: Text('Select All'),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _textController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _textController.text.length,
              );
              _focusNode.requestFocus();
            },
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
