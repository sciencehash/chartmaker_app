import 'package:chartmaker_app/widgets/charts_page/templates_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_scaffold.dart';

class EnginesBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChartsBottomSheetScaffold(
      appBarTitle: 'Select a chart engine',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Each chart engine has its own designs and customization options.',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'You can always create new charts, but it is not possible to change the engine of a created chart.',
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              FlatButton(
                child: Text('Chartjs'),
                padding: const EdgeInsets.all(50),
                color: Color(0xfffe777b),
                minWidth: 200,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) => TemplatesBottomSheet(
                      lib: 'chartjs',
                    ),
                  );
                },
              ),
              FlatButton(
                child: Text('ApexCharts'),
                padding: const EdgeInsets.all(50),
                color: Color(0xff2c97f3),
                minWidth: 200,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) => TemplatesBottomSheet(
                      lib: 'apexcharts',
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
