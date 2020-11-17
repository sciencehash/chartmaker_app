import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

part 'app_chart.g.dart';

@JsonSerializable(nullable: false)
 class AppChart extends Equatable {
  AppChart({
    @required this.id,
    @required this.userId,
    @required this.libraryId,
    @required this.title,
    @required this.config,
    @required this.utcLastUpdate,
    @required this.activated,
    this.thumbnail,
  });

  final int id;
  final int userId;
  final int libraryId;
  final String title;
  final Map config;
  final DateTime utcLastUpdate;
  final bool activated;

  // Auto generated values
  @JsonKey(ignore: true)
  final Uint8List thumbnail;

  @override
  List<Object> get props => [
        id,
        userId,
        libraryId,
        title,
        config,
        utcLastUpdate,
        activated,
        thumbnail,
      ];

  AppChart copyWith({
    int id,
    int userId,
    int libraryId,
    String title,
    Map config,
    DateTime utcLastUpdate,
    bool activated,
    Uint8List thumbnail,
  }) {
    return AppChart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      libraryId: libraryId ?? this.libraryId,
      title: title ?? this.title,
      config: config ?? this.config,
      utcLastUpdate: utcLastUpdate ?? this.utcLastUpdate,
      activated: activated ?? this.activated,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  List<Map> getClonedDatasets() {
    //
    if (config['lib'] == 'chartjs') {
      return List.castFrom<dynamic, Map>(
        jsonDecode(jsonEncode(config['config']['data']['datasets'])),
      );
    } else if (config['lib'] == 'apexcharts') {
      return List.castFrom<dynamic, Map>(
        jsonDecode(jsonEncode(config['config']['series'])),
      );
    } else {
      return [];
    }
  }

  Map getClonedConfig() {
    //
    if (config['lib'] == 'chartjs') {
      return Map.from(
        jsonDecode(jsonEncode(config)),
      );
    } else if (config['lib'] == 'apexcharts') {
      // return List.castFrom<dynamic, Map>(
      //   jsonDecode(jsonEncode(config['config']['series'])),
      // );
      return {};
    } else {
      return {};
    }
  }

  factory AppChart.fromJson(Map<String, dynamic> json) =>
      _$AppChartFromJson(json);

  Map<String, dynamic> toJson() => _$AppChartToJson(this);

  AppChart.fromSembastSnapshot(RecordSnapshot snapshot)
      : id = snapshot.key as int,
        userId = snapshot.value['userId'] as int,
        libraryId = snapshot.value['libraryId'] as int,
        title = snapshot.value['title'] as String,
        config = snapshot.value['config'] as Map<String, dynamic>,
        utcLastUpdate =
            (snapshot.value['utcLastUpdate'] as Timestamp).toDateTime(),
        activated = snapshot.value['activated'] as bool,
        thumbnail = null;

  Map<String, dynamic> toDocument() {
    // Firebase document is toJson without 'id' field
    final Map<String, dynamic> fbDocument = this.toJson();
    fbDocument.remove('id');

    // Convert DateTime to Firebase Timestamp
    fbDocument['utcLastUpdate'] = Timestamp.fromDateTime(this.utcLastUpdate);

    // Return
    return fbDocument;
  }

  @override
  bool get stringify => true;

  ///
  String getEmbedContent({
    bool withEditorScript = false,
  }) {
    String lib = this.config['lib'];
    Map config = this.config['config'];

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
      '''<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw==" crossorigin="anonymous"></script>''';
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
