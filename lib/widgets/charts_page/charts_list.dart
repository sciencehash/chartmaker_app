import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/app_chart.dart';
import '../../cubits/app_chart/app_chart_cubit.dart';
import '../../pages/editor.dart';

class ChartsPageList extends StatelessWidget {
  final List<AppChart> charts;

  ChartsPageList({
    Key key,
    @required this.charts,
  }) : super(key: key);

  final Map _chartEngines = {
    'chartjs': 'Chart.js',
    'apexcharts': 'ApexCharts',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (AppChart chart in charts)
          ListTile(
            title: Text(chart.title),
            subtitle: Text('Engine: ${_chartEngines[chart.config['lib']]}'),
            onTap: () {
              Navigator.pushNamed(
                context,
                ChartEditor.baseRoute + '/' + chart.id,
              );
            },
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.pink,
              ),
              onPressed: () {
                context.bloc<AppChartCubit>().deleteAppChart(
                  chart,
                );
              },
            ),
          ),
      ],
    );
  }
}
