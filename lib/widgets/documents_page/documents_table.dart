import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cubits/local_storage/local_storage_cubit.dart';
import '../../models/app_document.dart';
import '../../cubits/app_document/app_document_cubit.dart';
import '../../pages/editor.dart';

class DocumentsPageTable extends StatelessWidget {
  final List<AppDocument> documents;

  DocumentsPageTable({
    Key key,
    @required this.documents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final localStorageDb =
    //     (context.bloc<LocalStorageCubit>().state as LocalStorageLoaded).db;

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Preview',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Title',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Cloud',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Actions',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: <DataRow>[
        for (AppDocument document in documents)
          DataRow(
            cells: <DataCell>[
              DataCell(
                document.coverThumbnail == null
                    ? Text('...')
                    : Image.memory(
                        document.coverThumbnail,
                        filterQuality: FilterQuality.high,
                      ),
              ),
              DataCell(Text(document.title)),
              DataCell(
                Text(
                  ['pCloud', 'GDrive', 'Dropbox'][document.provider.index],
                ),
              ),
              DataCell(
                Row(
                  children: [
                    RaisedButton(
                      child: Text('View'),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ChartEditor.baseRoute + '/' + document.id,
                      ),
                    ),
                    SizedBox(width: 13),
                    RaisedButton(
                      color: Colors.pink,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        context.bloc<AppDocumentCubit>().deleteAppDocument(
                              document,
                            );
                      },
                    ),
                    SizedBox(width: 13),
                    RaisedButton(
                      child: Text(
                        'Sync',
                      ),
                      onPressed: () {
                        // context.bloc<AppDocumentCubit>().updateAppDocument(
                        //       appDocument: document,
                        //       localStorageDb: localStorageDb,
                        //     );
                      },
                    ),
                  ],
                ),
              ),
            ],
            onSelectChanged: (value) {
              Navigator.pushNamed(
                context,
                ChartEditor.baseRoute + '/' + document.id,
              );
            },
          ),
      ],
      showCheckboxColumn: false,
    );
  }
}
