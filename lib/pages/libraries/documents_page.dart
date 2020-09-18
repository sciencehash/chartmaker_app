import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import '../../models/app_library.dart';
import '../../cubits/app_library/app_library_cubit.dart';

import '../../models/app_document.dart';
import '../../cubits/app_document/app_document_cubit.dart';

import '../../widgets/app/app_scaffold.dart';
import '../../widgets/app/page_title.dart';
import '../../widgets/app/bloc_loading_progress_indicator.dart';
import '../../widgets/app/empty_list_message.dart';
import '../../widgets/documents_page/documents_table.dart';
import '../../widgets/documents_page/documents_grid.dart';
import '../editor.dart';

class LibraryDocumentsPage extends StatefulWidget {
  static const String baseRoute = '/library';

  const LibraryDocumentsPage({Key key, this.libraryId}) : super(key: key);

  final String libraryId;

  @override
  _LibraryDocumentsPageState createState() => _LibraryDocumentsPageState();
}

class _LibraryDocumentsPageState extends State<LibraryDocumentsPage> {
  @override
  Widget build(BuildContext context) {
    //
    final String uid =
        (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;

    return AppScaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AppLibraryCubit, AppLibraryState>(
            builder: (context, libraryState) {
              if (libraryState is AppLibrariesLoaded) {
                return BlocBuilder<AppDocumentCubit, AppDocumentState>(
                  builder: (context, documentState) {
                    if (documentState is AppDocumentsLoaded) {
                      return ListView(
                        children: [
                          PageTitle(
                              title: 'Documents',
                              details: 'Your PDF documents'),
                          if (documentState.appDocuments.length > 0)
                            DocumentsPageTable(documents: documentState.appDocuments,),
                          if (documentState.appDocuments.length == 0)
                            EmptyListMessage(
                              message:
                                  "You don't have documents yet, you can add one now.",
                              buttonLabel: 'Add new PDF document',
//                      onButtonPressed: () => Navigator.pushNamed(
//                        context,
//                        AppLibraryEditorPage.baseRoute,
//                      ),
                            ),
                        ],
                      );
                    } else {
                      //
                      context.bloc<AppDocumentCubit>().loadAppDocuments(
                            userId: uid,
                            libraryId: widget.libraryId,
                          );
                      return BlocLoadingProgressIndicator();
                    }
                  },
                );
              } else {
                //
                context.bloc<AppLibraryCubit>().loadAppLibraries(userId: uid);
                //
                return BlocLoadingProgressIndicator();
              }
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            ChartEditor.baseRoute,
          );
        },
      ),
    );
  }
}
