import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../models/app_chart.dart';
import '../../widgets/chart_editor_page/datasets_editor_page/datasets_editor_scaffold.dart';
import '../../cubits/editor/editor_cubit.dart';

class DatasetsEditorPage extends StatefulWidget {
  @override
  _DatasetsEditorPageState createState() => _DatasetsEditorPageState();
}

class _DatasetsEditorPageState extends State<DatasetsEditorPage> {
  final _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  List<Map> datasets = [];
  String lib;

  List<List<TextEditingController>> textControllers = [];
  List<List<FocusNode>> focusNodes = [];

  LinkedScrollControllerGroup _hLinkedControllers;
  final List<List<ScrollController>> _hScrollControllers = [];

  @override
  void initState() {
    //
    AppChart appChart =
        (context.bloc<EditorCubit>().state as EditorLoaded).appChart;
    //
    lib = appChart.config['lib'];
    //
    datasets = appChart.getClonedDatasets();

    // Horizontal Linked Scroll Controllers
    _hLinkedControllers = LinkedScrollControllerGroup();

    super.initState();
  }

  @override
  void dispose() {
    //
    for (List<ScrollController> sc in _hScrollControllers) {
      sc[0].dispose(); // ExpansionTile title scroll
      sc[1].dispose(); // ExpansionTile children scroll
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Prepare all controllers
    for (int dsi = 0; dsi < datasets.length; dsi++) {
      //
      // Horizontal linked scroll controllers
      //

      _hScrollControllers.add([
        _hLinkedControllers.addAndGet(), // Column identifier (A-Z)
        _hLinkedControllers.addAndGet(), // Column label
      ]);

      if (_hScrollControllers.length < datasets.length + 1) {
        _hScrollControllers.add([
          _hLinkedControllers.addAndGet(), // ExpansionTile title scroll
          _hLinkedControllers.addAndGet(), // ExpansionTile children scroll
        ]);
      }

      //
      // Text and Focus Controllers
      //

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

    // Add top column identifier
    listChildren.add(
      ListTile(
        title: SingleChildScrollView(
          controller: _hScrollControllers.first[0],
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 60),
              for (int di = 0; di < datasets.first.length; di++)
                Container(
                  width: 100,
                  padding: const EdgeInsets.only(right: 7),
                  child: Text(
                    _alphabet[di],
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    // Add column label textfield
    listChildren.add(
      ListTile(
        title: SingleChildScrollView(
          controller: _hScrollControllers.first[1],
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 60),
              for (int di = 0; di < datasets.first.length; di++)
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 50,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 80, // hardcoded
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white24,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: SizedBox(),
                      // child: EditableText(
                      //   controller: textControllers[dsi][di],
                      //   focusNode: focusNodes[dsi][di],
                      //   style: TextStyle(color: Colors.white),
                      //   cursorColor: Colors.white,
                      //   backgroundCursorColor: Colors.white,
                      //   keyboardType: TextInputType.numberWithOptions(
                      //     signed: true,
                      //     decimal: true,
                      //   ),
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(
                      //       RegExp(r'(^\-?\d*\.?\d*)$'),
                      //     ),
                      //   ], // Only numbers can be entered
                      // ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    // Create list elements (datasets rows and columns)
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
            title: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _hScrollControllers[dsi + 1][0],
                    child: Row(
                      children: [
                        Icon(Icons.arrow_right),
                        SizedBox(width: 10),
                        // Row identifier
                        Container(
                          width: 30,
                          child: Text(
                            (dsi + 1).toString(),
                            style: TextStyle(color: Colors.white38),
                          ),
                        ),

                        SizedBox(width: 10),
                        for (int di = 0; di < data.length; di++)
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 50,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 80, // hardcoded
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white24,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: EditableText(
                                  controller: textControllers[dsi][di],
                                  focusNode: focusNodes[dsi][di],
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  backgroundCursorColor: Colors.white,
                                  keyboardType: TextInputType.numberWithOptions(
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
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _hScrollControllers[dsi + 1][1],
                child: Padding(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
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
                            color:
                                Theme.of(context).primaryColor.withOpacity(.5),
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

    return DatasetsEditorScaffold(
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

        //
        Map editableAppChartConfig = appChart.getClonedConfig();

        if (lib == 'chartjs') {
          //
          editableAppChartConfig['config']['data']['datasets'] = datasets;
        } else if (lib == 'apexcharts') {
          //
          editableAppChartConfig['config']['series'] = datasets;
        }

        //
        context.bloc<EditorCubit>().updateChart(
              appChart: appChart.copyWith(
                config: editableAppChartConfig,
              ),
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
