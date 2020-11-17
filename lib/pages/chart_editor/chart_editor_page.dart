import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/app_library/app_library_cubit.dart';
import '../../cubits/app_chart/app_chart_cubit.dart';
import '../../cubits/editor/editor_cubit.dart';
import '../../widgets/chart_editor_page/shared/editor_scaffold.dart';
import '../../widgets/app/bloc_loading_progress_indicator.dart';
import '../../widgets/chart_editor_page/shared/chart_viewer.dart';
import '../../widgets/chart_editor_page/chartjs/basic_panel.dart';
import '../../widgets/chart_editor_page/apexcharts/basic_panel.dart';

class ChartEditor extends StatefulWidget {
  static const String baseRoute = '/editor';

  final int chartId;

  ChartEditor({Key key, this.chartId}) : super(key: key);

  @override
  _ChartEditorState createState() => _ChartEditorState();
}

class _ChartEditorState extends State<ChartEditor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    // String uid =
    //     (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;
    // TODO: HARDCODED user id
    final int uid = 1;

    return BlocBuilder<EditorCubit, EditorState>(
        builder: (context, editorState) {
      return BlocBuilder<AppChartCubit, AppChartState>(
          builder: (context, chartState) {
        if (editorState is EditorLoaded) {
          //
          return EditorScaffold(
            leftTabBarChildren: <Tab>[
              Tab(icon: Icon(Icons.home)), // Basic
              Tab(icon: Icon(Icons.bubble_chart)), // Animations
              Tab(icon: Icon(Icons.beenhere)), // DataLabels
              Tab(icon: Icon(Icons.developer_mode)), // Interactivity
              Tab(icon: Icon(Icons.border_clear)), // Grid
              Tab(icon: Icon(Icons.art_track)), // Legend
            ],
            leftTabViewChildren: <Widget>[
              // Basic panel
              editorState.appChart.config['lib'] == 'apexcharts'
                  ? ApexChartsBasicPanel()
                  : ChartJsBasicPanel(),
              // Animations panel
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Animations options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Text('Nothing here yet'),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
              // DataLabels panel
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DataLabels options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Text('Nothing here yet'),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
              // Interactivity panel
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interactivity options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Text('Nothing here yet'),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
              // Grid panel
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grid options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Text('Nothing here yet'),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
              // Legend panel
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Legend options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Text('Nothing here yet'),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
            ],
            body: ListView(
              children: [
                if (editorState.hideViewer)
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('Waiting for your choice'),
                        SizedBox(height: 12),
                        Container(
                          width: 200,
                          height: 2,
                          child: LinearProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Colors.white,
                  child: ChartViewer(
                    appChart: editorState.appChart,
                  ),
                ),
              ],
            ),
            initialChartTitle: editorState.appChart.title,
            onChartTitleChanged: (value) {
              context.bloc<EditorCubit>().updateChart(
                    appChart: editorState.appChart.copyWith(title: value),
                  );
            },
            onSavePressed: () {
              if (widget.chartId == null) {
                context.bloc<AppChartCubit>().addAppChart(
                      editorState.appChart,
                    );
              } else {
                context.bloc<AppChartCubit>().updateAppChart(
                      appChart: editorState.appChart,
                    );
              }
              //
              Navigator.pop(context);
            },
          );
        } else {
          if (widget.chartId == null) {
            //
            context.bloc<EditorCubit>().loadEditorFromChartTemplate(
                  userId: uid,
                  libraryId: context.bloc<AppLibraryCubit>().currentLibraryId,
                );
          } else {
            //
            context.bloc<EditorCubit>().loadEditorFromAppChart(
                  userId: uid,
                  appChartId: widget.chartId,
                );
          }
          //
          return Scaffold(
            body: BlocLoadingProgressIndicator(),
          );
        }
      });
    });
  }
}
