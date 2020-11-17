import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';
import '../../../pages/chart_editor/datasets_editor_page.dart';
import '../../../widgets/chart_editor_page/shared/embed_content.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 25),
            icon: Icon(Icons.equalizer),
            label: Text('Datasets'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.bloc<EditorCubit>(),
                    child: DatasetsEditorPage(),
                  ),
                ),
              );
            },
          ),
          Expanded(child: SizedBox()),
          FlatButton.icon(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 25),
            icon: Icon(Icons.code),
            label: Text('Embed'),
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.bloc<EditorCubit>(),
                  child: EmbedContent(),
                ),
              );

            },
          ),
          // FlatButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.share),
          //   label: Text('Share'),
          // ),
          FlatButton.icon(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 25),
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
