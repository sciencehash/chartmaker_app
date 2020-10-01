import 'dart:math' as math;
import 'dart:convert';

import 'package:meta/meta.dart';

class EditorUtils {
  static String getEmbedContent({
    @required String lib,
    @required Map config,
    bool withEditorScript = false,
  }) {
    String content = '';

    //
    math.Random rand = math.Random();

    final String chartId = 'chart${rand.nextInt(99999)}';

    //
    StringBuffer jsString = StringBuffer();

    //
    String chartConfig = jsonEncode(config);

    // Replace JSON key format ("key":) to JavaScript key format (key:)
    chartConfig = chartConfig.replaceAllMapped(
      RegExp(r'"([^"]+?)"\s*:'),
      (Match m) => '${m[1]}:',
    );

    // Escape single quotes
    chartConfig = chartConfig.replaceAll("'", r"\'");

    // Replace double quotes with simple quotes
    chartConfig = chartConfig.replaceAll('"', "'");

    //
    if (lib == 'chartjs') {
      //
      jsString.write(
        '''chartjs = new Chart(document.getElementById('$chartId').getContext('2d'), $chartConfig);''',
      );

      content = '''<canvas id="$chartId"></canvas>''';
      content +=
          '''<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script>''';
    } else if (lib == 'apexcharts') {
      //
      jsString.write(
        '''apexchart = new ApexCharts(document.querySelector("#$chartId"), $chartConfig);''',
      );
      //
      jsString.write('''apexchart.render();''');

      content = '''<div id="$chartId"></div>''';
      content +=
          '''<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>''';
    }

    if(withEditorScript) {
      //
      content += '''<script src="editor-script.js" id="editorscript" lib="$lib" chartid="$chartId"></script>''';
    }

    //
    content += '''<script>${jsString.toString()}</script>''';

    //
    return content;
  }
}
