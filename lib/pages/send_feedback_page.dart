import 'package:flutter/material.dart';

import '../widgets/app/app_scaffold.dart';
import '../widgets/app/page_title.dart';

class SendFeedbackPage extends StatelessWidget {
  static const String route = '/send-feedback';

  const SendFeedbackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Send feedback'),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Nothing here yet.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),          ],
        ),
      ),
    );

  }
}