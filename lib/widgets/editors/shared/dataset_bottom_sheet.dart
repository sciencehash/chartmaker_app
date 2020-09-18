import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';

class DatasetBottomSheet extends StatelessWidget {


  var _c = TextEditingController();
  var _f = FocusNode();


  @override
  Widget build(BuildContext context) {

    Map chartJsConfig =
        (context.bloc<EditorCubit>().state as EditorLoaded).chartConfig;

    _c.text = json.encode(chartJsConfig['data']['datasets'][0]['data']);

    return Column(
      children: [
        Text('MAS'),
        Container(),
        EditableText(
          controller: _c,
          focusNode: _f,
          style: TextStyle(),
          cursorColor: Colors.black45,
          backgroundCursorColor: Colors.red,
        ),
        FlatButton(
          onPressed: () {
            chartJsConfig['data']['datasets'][0]['data'] = json.decode(_c.text);

            //
            context.bloc<EditorCubit>().updateChart(
                  chartConfig: chartJsConfig,
                );
            Scaffold.of(context).showBottomSheet((context) => Text('Algo'));
          },
          child: Text('AAA'),
        )
      ],
    );
  }
}
