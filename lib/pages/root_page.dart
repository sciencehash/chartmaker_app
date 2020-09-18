import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import '../models/app_library.dart';
import '../cubits/app_library/app_library_cubit.dart';

import '../widgets/app/app_scaffold.dart';
import '../widgets/app/bloc_loading_progress_indicator.dart';

import 'redirection_page.dart';
import 'libraries/documents_page.dart';

class RootPage extends StatelessWidget {
  static const String route = '/';

  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final String uid =
        (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;

    return AppScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AppLibraryCubit, AppLibraryState>(
          builder: (context, state) {
            if (state is AppLibrariesLoaded) {
              //
              if (state.appLibraries.length == 0) {
                // Add the first default library
                context.bloc<AppLibraryCubit>().addAppLibrary(
                      AppLibrary.defaultLibrary(uid),
                    );
              } else {
                // Redirect to the first library
                return RedirectionPage(
                  routeName: LibraryDocumentsPage.baseRoute +
                      '/' +
                      state.appLibraries.first.id,
                  clearHistory: true,
                );
              }
            } else {
              // Load user libraries
              context.bloc<AppLibraryCubit>().loadAppLibraries(
                    userId: uid,
                  );
            }
            //
            return BlocLoadingProgressIndicator();
          },
        ),
      ),
    );
  }
}