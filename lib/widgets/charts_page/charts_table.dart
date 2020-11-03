import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/app_chart.dart';
import '../../cubits/app_chart/app_chart_cubit.dart';
import '../../pages/chart_editor/chart_editor_page.dart';

class ChartsPageTable extends StatelessWidget {
  final List<AppChart> charts;

  ChartsPageTable({
    Key key,
    @required this.charts,
  }) : super(key: key);

  final Map _chartEngines = {
    'chartjs': 'Chart.js',
    'apexcharts': 'ApexCharts',
  };

  @override
  Widget build(BuildContext context) {
    //
    // final localStorageDb =
    //     (context.bloc<LocalStorageCubit>().state as LocalStorageLoaded).db;

    return DataTable(
      columns: const <DataColumn>[
        // DataColumn(
        //   label: Text(
        //     'Preview',
        //     style: TextStyle(fontStyle: FontStyle.italic),
        //   ),
        // ),
        DataColumn(
          label: Text(
            'Title',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Engine',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Actions',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: <DataRow>[
        for (AppChart chart in charts)
          DataRow(
            cells: <DataCell>[
              // DataCell(
              //   chart.coverThumbnail == null
              //       ? Text('...')
              //       : Image.memory(
              //           chart.coverThumbnail,
              //           filterQuality: FilterQuality.high,
              //         ),
              // ),
              DataCell(
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(chart.title),
                ),
              ),
              DataCell(
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(_chartEngines[chart.config['lib']]),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    FlatButton(
                      child: Icon(
                        Icons.delete,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        context.bloc<AppChartCubit>().deleteAppChart(
                              chart,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
            onSelectChanged: (value) {
              Navigator.pushNamed(
                context,
                ChartEditor.baseRoute + '/' + chart.id,
              );
            },
          ),
      ],
      showCheckboxColumn: false,
    );
  }
}
