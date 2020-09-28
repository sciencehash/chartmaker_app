import 'dart:convert';

import 'package:chartmaker_app/models/app_chart.dart';
import 'package:chartmaker_app/widgets/editors/shared/bottom_sheet_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';

class DatasetBottomSheet extends StatefulWidget {
  @override
  _DatasetBottomSheetState createState() => _DatasetBottomSheetState();
}

class _DatasetBottomSheetState extends State<DatasetBottomSheet> {
  List<Map> datasets = [];
  String lib;

  List<List<TextEditingController>> textControllers = [];
  List<List<FocusNode>> focusNodes = [];

  @override
  void initState() {
    //
    AppChart appChart =
        (context.bloc<EditorCubit>().state as EditorLoaded).appChart;
    //
    lib = appChart.config['lib'];
    //
    datasets = appChart.getClonedDatasets();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    for (int dsi = 0; dsi < datasets.length; dsi++) {
      Map dataset = datasets[dsi];
      List data = [];
      //
      if (lib == 'chartjs') {
        // datasets = List.from(appChart.config['config']['data']['datasets']);
        data = dataset['data'];
      } else if (lib == 'apexcharts') {
        // datasets = List.from(appChart.config['config']['series']);
        data = dataset['data'];
      }
      //
      if (dsi > textControllers.length - 1) {
        textControllers.add([]);
        focusNodes.add([]);
      }
      //
      for (int di = 0; di < data.length; di++) {
        if (di > textControllers[dsi].length - 1) {
          //
          textControllers[dsi].add(TextEditingController());
          //
          focusNodes[dsi].add(FocusNode());
        }
        //
        textControllers[dsi][di].text = data[di].toString();
        //
        textControllers[dsi][di].addListener(() {
          data[di] = double.tryParse(textControllers[dsi][di].text);
        });
      }
    }

    //
    final ScrollController scrollController = ScrollController();

    final List<Widget> listChildren = [];

    //
    for (int dsi = 0; dsi < datasets.length; dsi++) {
      Map dataset = datasets[dsi];
      List data = [];
      //
      if (lib == 'chartjs') {
        data = dataset['data'];
      } else if (lib == 'apexcharts') {
        data = dataset['data'];
      }
      //
      listChildren.add(
        Container(
          color: dsi.isEven ? Colors.white.withOpacity(.05) : null,
          child: ExpansionTile(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            // backgroundColor:
            //     index.isEven ? Colors.white.withOpacity(.05) : null,
            title: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_right),
                        SizedBox(width: 10),
                        for (int di = 0; di < data.length; di++)
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 50,
                              ),
                              padding: const EdgeInsets.all(5),
                              // color: Colors.white.withOpacity(.3),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50, // hardcoded
                                    child: EditableText(
                                      controller: textControllers[dsi][di],
                                      focusNode: focusNodes[dsi][di],
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.white,
                                      backgroundCursorColor: Colors.white,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        signed: true,
                                        decimal: true,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'(^\-?\d*\.?\d*)$'),
                                        ),
                                      ], // Only numbers can be entered
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    ',',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.grey,
                                          height: 0.9,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Tooltip(
                //   message: 'Configure dataset',
                //   child: FlatButton(
                //     child: Icon(Icons.settings),
                //     padding: const EdgeInsets.symmetric(horizontal: 7),
                //     minWidth: 20,
                //     onPressed: () {
                //       print('Settings');
                //     },
                //   ),
                // ),
                Tooltip(
                  message: 'Delete dataset',
                  child: FlatButton(
                    child: Icon(Icons.delete, color: Colors.pink),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        datasets.removeAt(dsi);
                      });
                    },
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(width: 42),
                    for (int di = 0; di < data.length; di++)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 31),
                        child: Tooltip(
                          message: 'Remove column',
                          child: FlatButton(
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.pink,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            minWidth: 20,
                            onPressed: () {
                              if (lib == 'chartjs') {
                                datasets.forEach(
                                  (dataset) => dataset['data'].removeAt(di),
                                );
                              } else if (lib == 'apexcharts') {
                                datasets.forEach(
                                  (dataset) => dataset['data'].removeAt(di),
                                );
                              }
                              setState(() {
                                // refresh
                              });
                            },
                          ),
                        ),
                      ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: 'Add new column',
                      child: FlatButton(
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        minWidth: 20,
                        onPressed: () {
                          if (lib == 'chartjs') {
                            datasets.forEach(
                              (dataset) => dataset['data'].add(0),
                            );
                          } else if (lib == 'apexcharts') {
                            datasets.forEach(
                              (dataset) => dataset['data'].add(0),
                            );
                          }
                          setState(() {
                            // refresh
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  initialValue: lib == 'chartjs'
                      ? (datasets[dsi]['label'] ?? '')
                      : (datasets[dsi]['name'] ?? ''),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    labelText: 'Label',
                  ),
                  onChanged: (value) {
                    if (lib == 'chartjs') {
                      datasets[dsi]['label'] = value;
                    } else if (lib == 'apexcharts') {
                      datasets[dsi]['name'] = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return EditorBottomSheetScaffold(
      appBarTitle: 'Datasets',
      body: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: ListView(
          controller: scrollController,
          children: listChildren,
        ),
      ),
      onApplyPressed: () {
        //
        AppChart appChart =
            (context.bloc<EditorCubit>().state as EditorLoaded).appChart;

        if (lib == 'chartjs') {
          //
          appChart.config['config']['data']['datasets'] = datasets;
        } else if (lib == 'apexcharts') {
          //
          appChart.config['config']['series'] = datasets;
        }

        //
        context.bloc<EditorCubit>().updateChart(
              appChart: appChart,
            );

        //
        Navigator.pop(context);
      },
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final int datasetLength =
              datasets.length > 0 ? datasets[0]['data'].length : 5;
          //
          datasets.add(
            {
              lib == 'chartjs' ? 'label' : 'name': 'New dataset',
              'data': List.generate(datasetLength, (index) => 0),
            },
          );
          setState(() {
            if (lib == 'chartjs') {
              datasets.last['label'] = 'New dataset';
            } else if (lib == 'apexcharts') {
              datasets.last['name'] = 'New dataset';
            }
          });
        },
      ),
    );
  }
}
