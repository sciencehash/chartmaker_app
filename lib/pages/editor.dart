import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_document/app_document_cubit.dart';
import '../cubits/editor/editor_cubit.dart';
import '../widgets/editors/shared/editor_scaffold.dart';
import '../widgets/app/page_title.dart';
import '../widgets/app/bloc_loading_progress_indicator.dart';
import '../widgets/editors/shared/chart_viewer.dart';

class ChartEditor extends StatefulWidget {
  static const String baseRoute = '/editor';

  final String documentId;

  ChartEditor({Key key, this.documentId}) : super(key: key);

  @override
  _ChartEditorState createState() => _ChartEditorState();
}

class _ChartEditorState extends State<ChartEditor> {
  bool _isNewChart;


  @override
  void initState() {
    _isNewChart = widget.documentId == null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorCubit, EditorState>(
        builder: (context, editorState) {
      return BlocBuilder<AppDocumentCubit, AppDocumentState>(
          builder: (context, documentState) {
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
              Container(
                child: Text('Basic'),
                padding: EdgeInsets.all(20),
              ),
              Container(child: Text('Animations'), padding: EdgeInsets.all(20)),
              Container(child: Text('DataLabels'), padding: EdgeInsets.all(20)),
              Container(
                  child: Text('Interactivity'), padding: EdgeInsets.all(20)),
              Container(child: Text('Grid'), padding: EdgeInsets.all(20)),
              Container(child: Text('Legend'), padding: EdgeInsets.all(20)),
            ],
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Colors.white,
                  child: ChartViewer(config: editorState.chartConfig),
                ),
              ],
            ),
          );
        } else {
          //
          context.bloc<EditorCubit>().loadEditor(templateId: 'lineTemplate01');
          //
          return Scaffold(
            body: BlocLoadingProgressIndicator(),
          );
        }
      });
    });
  }
}
