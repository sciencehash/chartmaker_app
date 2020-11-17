import 'package:flutter/material.dart';

import 'templates_page.dart';
import '../widgets/app/secondary_scaffold.dart';

class EnginesPage extends StatelessWidget {
  static const String route = '/engines';

  @override
  Widget build(BuildContext context) {
    return SecondaryScaffold(
      appBarTitle: 'Select a chart engine',
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
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
                    Navigator.pushNamed(
                      context,
                      TemplatesPage.baseRoute + '/chartjs',
                    );
                  },
                ),
                FlatButton(
                  child: Text('ApexCharts'),
                  padding: const EdgeInsets.all(50),
                  color: Color(0xff2c97f3),
                  minWidth: 200,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      TemplatesPage.baseRoute + '/apexcharts',
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
