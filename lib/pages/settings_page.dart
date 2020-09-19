import 'package:flutter/material.dart';

import '../widgets/app/app_scaffold.dart';
import '../widgets/app/page_title.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Settings'),
          ],
        ),
      ),
    );

  }
}