import 'package:flutter/material.dart';

class ApexChartsBasicPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic options',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Text('Nothing here yet (Apex)'),
        ],
      ),
      padding: EdgeInsets.all(20),
    );
  }
}