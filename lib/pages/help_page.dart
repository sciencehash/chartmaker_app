import 'package:flutter/material.dart';

import '../widgets/app/primary_scaffold.dart';
import '../widgets/app/page_title.dart';

class HelpPage extends StatelessWidget {
  static const String route = '/help';

  const HelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Help'),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Nothing here yet.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
