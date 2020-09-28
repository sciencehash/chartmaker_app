import 'dart:html' as html;

import 'package:chartmaker_app/cubits/editor/editor_cubit.dart';
import 'package:chartmaker_app/widgets/editors/shared/dataset_bottom_sheet.dart';
import 'package:chartmaker_app/widgets/editors/shared/embed_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            label: Text('Datasets'),
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   builder: (_) => BlocProvider.value(
              //     value: context.bloc<EditorCubit>(),
              //     child: DatasetBottomSheet(),
              //   ),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.bloc<EditorCubit>(),
                    child: DatasetBottomSheet(),
                  ),
                ),
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
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return EmbedContent();
                  });

              // showDialog<void>(
              //   context: context,
              //   barrierDismissible: false, // user must tap button!
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text('Help'),
              //       content: SingleChildScrollView(
              //         child: ListBody(
              //           children: <Widget>[
              //             SelectableText(
              //               'Each dataset allows you to configure options that will replace the general options of the chart.',
              //             ),
              //           ],
              //         ),
              //       ),
              //       actions: <Widget>[
              //         FlatButton(
              //           child: Text('Ok'),
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // );
            },
          ),
          // FlatButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.share),
          //   label: Text('Share'),
          // ),
          FlatButton.icon(
            icon: Icon(Icons.file_download),
            label: Text('Export'),
            onPressed: () {
              context.bloc<EditorCubit>().downloadAsPNG();
            },
          ),
          // PopupMenuButton<ExportMenuOptions>(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          //     child: Row(
          //       children: [
          //         Icon(Icons.file_download),
          //         SizedBox(width: 8),
          //         Text('Export'),
          //       ],
          //     ),
          //   ),
          //   offset: Offset(0, 37),
          //   onSelected: (ExportMenuOptions result) {
          //     // setState(() {
          //     //   _selection = result;
          //     // });
          //   },
          //   itemBuilder: (BuildContext context) =>
          //       <PopupMenuEntry<ExportMenuOptions>>[
          //     const PopupMenuItem<ExportMenuOptions>(
          //       value: ExportMenuOptions.asPNG,
          //       child: Text('Export as PNG'),
          //     ),
          //     const PopupMenuItem<ExportMenuOptions>(
          //       value: ExportMenuOptions.getCode,
          //       child: Text('Get JavaScript code'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
