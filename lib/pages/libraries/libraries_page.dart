import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import '../../models/app_library.dart';
import '../../cubits/app_library/app_library_cubit.dart';

import '../../widgets/app/app_scaffold.dart';
import '../../widgets/app/page_title.dart';
import '../../widgets/app/empty_list_message.dart';

class LibraryLibrariesPage extends StatefulWidget {
  static const String route = '/';

  const LibraryLibrariesPage({Key key}) : super(key: key);

  @override
  _LibraryLibrariesPageState createState() => _LibraryLibrariesPageState();
}

class _LibraryLibrariesPageState extends State<LibraryLibrariesPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AppLibraryCubit, AppLibraryState>(
          builder: (context, state) {
            if (state is AppLibrariesLoaded) {
              return ListView(
                children: [
                  PageTitle(title: 'Social tools', details: 'Your social accounts'),
                  if (state.appLibraries.length > 0)
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Title',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
//                        DataColumn(
//                          label: Text(
//                            'Social network',
//                            style: TextStyle(fontStyle: FontStyle.italic),
//                          ),
//                        ),
                        DataColumn(
                          label: Text(
                            'Activated',
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
                        for (AppLibrary account in state.appLibraries)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(account.title)),
//                              DataCell(Text(account.socialNetwork.toString())),
                              DataCell(Text(account.activated.toString())),
                              DataCell(
                                Row(
                                  children: [
                                    RaisedButton(
                                      child: Text('Edit'),
//                                      onPressed: () => Navigator.pushNamed(
//                                        context,
//                                        AppLibraryEditorPage.baseRoute + '/' + account.id,
//                                      ),
                                    ),
                                    SizedBox(width: 13),
                                    RaisedButton(
                                      child: Text('View campaigns'),
//                                      onPressed: () => Navigator.pushNamed(
//                                        context,
//                                        SocialToolsCampaignsPage.baseRoute + '/' + account.id,
//                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onSelectChanged: (value) {
//                              Navigator.pushNamed(
//                                context,
//                                AppLibraryEditorPage.baseRoute + '/' + account.id,
//                              );
                            },
                          ),
                      ],
                      showCheckboxColumn: false,
                    ),
                  if (state.appLibraries.length == 0)
                    EmptyListMessage(
                      message: "You don't have social accounts yet, you can add one now.",
                      buttonLabel: 'Add new social account',
//                      onButtonPressed: () => Navigator.pushNamed(
//                        context,
//                        AppLibraryEditorPage.baseRoute,
//                      ),
                    ),
                ],
              );
            } else {
              //
              final String uid = (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;
              //
              context.bloc<AppLibraryCubit>().loadAppLibraries(userId: uid);
              //
              return Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
//        onPressed: () => Navigator.pushNamed(context, AppLibraryEditorPage.baseRoute),
      ),
    );
  }
}
