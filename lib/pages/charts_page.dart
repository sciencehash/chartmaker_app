import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_library/app_library_cubit.dart';

import '../cubits/app_chart/app_chart_cubit.dart';

import '../widgets/app/primary_scaffold.dart';
import '../widgets/app/page_title.dart';
import '../widgets/app/bloc_loading_progress_indicator.dart';
import '../widgets/app/empty_list_message.dart';
import '../widgets/charts_page/charts_table.dart';

// import '../widgets/charts_page/charts_grid.dart';
import '../widgets/charts_page/charts_list.dart';
import 'engines_page.dart';

class LibraryChartsPage extends StatefulWidget {
  static const String baseRoute = '/library';

  const LibraryChartsPage({Key key, this.libraryId}) : super(key: key);

  final int libraryId;

  @override
  _LibraryChartsPageState createState() => _LibraryChartsPageState();
}

class _LibraryChartsPageState extends State<LibraryChartsPage> {
  @override
  void initState() {
    //
    context.bloc<AppLibraryCubit>().currentLibraryId = widget.libraryId;
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    // final String uid =
    //     (context.bloc<AuthenticationCubit>().state as Authenticated).user.uid;
    // TODO: HARDCODED user id
    final int uid = 1;

    //
    final screenWidth = MediaQuery.of(context).size.width;

    // Same that PrimaryScaffold drawerMaxScreenWidth
    final minTableWidth = 900;

    return PrimaryScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AppLibraryCubit, AppLibraryState>(
          builder: (context, libraryState) {
            if (libraryState is AppLibrariesLoaded) {
              return BlocBuilder<AppChartCubit, AppChartState>(
                builder: (context, chartState) {
                  if (chartState is AppChartsLoaded) {
                    return ListView(
                      children: [
                        PageTitle(
                            title: 'Charts', details: 'Your saved charts'),
                        if (chartState.appCharts.length > 0)
                          screenWidth > minTableWidth
                              ? ChartsPageTable(
                                  charts: chartState.appCharts,
                                )
                              : ChartsPageList(
                                  charts: chartState.appCharts,
                                ),
                        if (chartState.appCharts.length == 0)
                          EmptyListMessage(
                            message:
                                "You don't have charts yet, you can add one now.",
                            buttonLabel: 'Add new Chart',
                            onButtonPressed: () => Navigator.pushNamed(
                              context,
                              EnginesPage.route,
                            ),
                          ),
                      ],
                    );
                  } else {
                    //
                    context.bloc<AppChartCubit>().loadAppCharts(
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
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(
              context,
              EnginesPage.route,
            );
          },
        );
      }),
    );
  }
}
