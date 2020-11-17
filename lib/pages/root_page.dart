import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_library/app_library_cubit.dart';

import '../widgets/app/primary_scaffold.dart';
import '../widgets/app/bloc_loading_progress_indicator.dart';

import 'redirection_page.dart';
import 'charts_page.dart';

class RootPage extends StatelessWidget {
  static const String route = '/';

  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final String uid =
    //     (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;
    // TODO: HARDCODED user id
    final int uid = 1;

    return PrimaryScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AppLibraryCubit, AppLibraryState>(
          builder: (context, state) {
            if (state is AppLibrariesLoaded) {
              if (state.appLibraries.isNotEmpty) {
                // Redirect to the first library
                return RedirectionPage(
                  routeName: LibraryChartsPage.baseRoute +
                      '/${state.appLibraries.first.id}',
                  clearHistory: true,
                );
              } else {
                //
                return BlocLoadingProgressIndicator();
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
