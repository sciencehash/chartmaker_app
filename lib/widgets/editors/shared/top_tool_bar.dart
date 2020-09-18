import 'package:chartmaker_app/widgets/editors/shared/dataset_bottom_sheet.dart';
import 'package:flutter/material.dart';

enum DatasetMenuOptions { edit, import, export }
enum ExportMenuOptions { asPNG, getCode }

class TopToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white.withOpacity(.05),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          FlatButton.icon(
            icon: Icon(Icons.equalizer),
            label: Text('Dataset'),
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (context) => DatasetBottomSheet(),
              );
            },
          ),
          // PopupMenuButton<DatasetMenuOptions>(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          //     child: Row(
          //       children: [
          //         Icon(Icons.equalizer),
          //         SizedBox(width: 8),
          //         Text('Dataset'),
          //       ],
          //     ),
          //   ),
          //   offset: Offset(0, 37),
          //   onSelected: (DatasetMenuOptions result) {
          //     // setState(() {
          //     //   _selection = result;
          //     // });
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<DatasetMenuOptions>>[
          //     const PopupMenuItem<DatasetMenuOptions>(
          //       value: DatasetMenuOptions.edit,
          //       child: Text('Edit'),
          //     ),
          //     const PopupMenuItem<DatasetMenuOptions>(
          //       value: DatasetMenuOptions.import,
          //       child: Text('Import'),
          //     ),
          //     const PopupMenuItem<DatasetMenuOptions>(
          //       value: DatasetMenuOptions.export,
          //       child: Text('Export'),
          //     ),
          //   ],
          // ),
          Expanded(child: SizedBox()),
          FlatButton.icon(
            icon: Icon(Icons.code),
            label: Text('Embed'),
            onPressed: () {},
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.share),
            label: Text('Share'),
          ),
          PopupMenuButton<ExportMenuOptions>(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              child: Row(
                children: [
                  Icon(Icons.file_download),
                  SizedBox(width: 8),
                  Text('Export'),
                ],
              ),
            ),
            offset: Offset(0, 37),
            onSelected: (ExportMenuOptions result) {
              // setState(() {
              //   _selection = result;
              // });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<ExportMenuOptions>>[
              const PopupMenuItem<ExportMenuOptions>(
                value: ExportMenuOptions.asPNG,
                child: Text('Export as PNG'),
              ),
              const PopupMenuItem<ExportMenuOptions>(
                value: ExportMenuOptions.getCode,
                child: Text('Get JavaScript code'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
