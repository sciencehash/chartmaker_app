import 'package:flutter/material.dart';

enum DatasetMenuOptions { edit, import, export }

class ChartJsBasicPanel extends StatelessWidget {
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
          Text('Nothing here yet (Chart)'),
          SizedBox(height: 20),
          PopupMenuButton<DatasetMenuOptions>(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              child: Row(
                children: [
                  Icon(Icons.equalizer),
                  SizedBox(width: 8),
                  Text('Dataset'),
                ],
              ),
            ),
            offset: Offset(0, 37),
            onSelected: (DatasetMenuOptions result) {
              print(result);
              // setState(() {
              //   _selection = result;
              // });
            },
            onCanceled: () {
              print('Nada entonces');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<DatasetMenuOptions>>[
              const PopupMenuItem<DatasetMenuOptions>(
                value: DatasetMenuOptions.edit,
                child: Text('Edit'),
              ),
              const PopupMenuItem<DatasetMenuOptions>(
                value: DatasetMenuOptions.import,
                child: Text('Import'),
              ),
              const PopupMenuItem<DatasetMenuOptions>(
                value: DatasetMenuOptions.export,
                child: Text('Export'),
              ),
            ],
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
    );
  }
}
