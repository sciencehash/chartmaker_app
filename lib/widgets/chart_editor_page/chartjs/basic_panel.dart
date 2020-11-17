import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';
import '../../../models/app_chart.dart';

import 'package:flutter_ui_widgets/flutter_ui_widgets.dart';

enum DatasetMenuOptions { edit, import, export }

enum AxesDisplayOptions {
  true_,
  false_,
  auto,
}

class ChartJsBasicPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    AppChart appChart =
        (context.bloc<EditorCubit>().state as EditorLoaded).appChart;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic options',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Text('Nothing here yet (Chart)'),
          //
          // 'title -> display' option
          //
          SwitchOption(
            margin: const EdgeInsets.only(top: 20),
            value: appChart.config['config']['options']['title']['display'],
            label: 'Display title',
            help: '...',
            onChanged: (value) {
              //
              Map editableAppChartConfig = appChart.getClonedConfig();

              //
              editableAppChartConfig['config']['options']['title']['display'] =
                  value;

              //
              context.bloc<EditorCubit>().updateChart(
                    appChart: appChart.copyWith(
                      config: editableAppChartConfig,
                    ),
                  );
            },
          ),
          //
          //
          //
          DropdownOption<AxesDisplayOptions>(
            margin: const EdgeInsets.only(top: 20),
            label: 'Axes display:',
            help: 'Controls the axis global visibility.',
            value: appChart.config['config']['options']['scales']['yAxes'][0]
                        ['display'] ==
                    'auto'
                ? AxesDisplayOptions.auto
                : (appChart.config['config']['options']['scales']['yAxes'][0]
                            ['display'] ==
                        false
                    ? AxesDisplayOptions.false_
                    : AxesDisplayOptions.true_),
            items: {
              AxesDisplayOptions.true_: {
                'label': 'True',
                'description': '''Visible''',
              },
              AxesDisplayOptions.false_: {
                'label': 'False',
                'description': '''Hidden''',
              },
              AxesDisplayOptions.auto: {
                'label': 'Auto',
                'description':
                    '''The axis is visible only if at least one associated dataset is visible''',
              },
            },
            onSetToDefaultValue: null,
            onSelected: (AxesDisplayOptions value) {
              //
              Map editableAppChartConfig = appChart.getClonedConfig();

              //
              editableAppChartConfig['config']['options']['scales']['yAxes'][0]
                      ['display'] =
                  value == AxesDisplayOptions.auto
                      ? 'auto'
                      : (value == AxesDisplayOptions.false_ ? false : true);

              //
              context.bloc<EditorCubit>().updateChart(
                    appChart: appChart.copyWith(
                      config: editableAppChartConfig,
                    ),
                  );
            },
          ),
          //
          // '' option
          //
          ColorOption(
            margin: const EdgeInsets.only(top: 20),
            label: 'primary',
            help:
                'The color displayed most frequently across your app’s screens and components.',
            initialColor: Colors.red,
            onColorSelected: (value) {},
            // isRequired: themeDataConfig.colorScheme.createWith ==
            //         ColorSchemeConstructors.unnamed &&
            //     themeDataConfig.colorScheme.primary == null,
            // initialColor: themeDataConfig.colorScheme.primary?.getInstance(),
            // onSetToNull: () {
            //   //
            //   context.bloc<EditorCubit>().updateTheme(
            //         themeDataConfig: themeDataConfig.copyWith(
            //           colorScheme:
            //               themeDataConfig.colorScheme.copyWithNullByPropName(
            //             {'primary'},
            //           ),
            //         ),
            //       );
            // },
            // onSetToDefaultValue:
            //     themeDataConfig.colorScheme.defaultValues.primary == null
            //         ? null
            //         : () {
            //             //
            //             context.bloc<EditorCubit>().updateTheme(
            //                   themeDataConfig: themeDataConfig.copyWith(
            //                     colorScheme:
            //                         themeDataConfig.colorScheme.copyWith(
            //                       primary: themeDataConfig
            //                           .colorScheme.defaultValues.primary,
            //                     ),
            //                   ),
            //                 );
            //           },
            // onColorSelected: (color) {
            //   //
            //   context.bloc<EditorCubit>().updateTheme(
            //         themeDataConfig: themeDataConfig.copyWith(
            //           colorScheme: themeDataConfig.colorScheme.copyWith(
            //             primary: ColorConfig(
            //               value: color.value,
            //             ),
            //           ),
            //         ),
            //       );
            // },
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
    );
  }
}
