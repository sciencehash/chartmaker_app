import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sembast/sembast.dart';
import '../../stubs/sembast/sembast_stub.dart'
    if (dart.library.io) '../../stubs/sembast/sembast_io.dart'
    if (dart.library.html) '../../stubs/sembast/sembast_web.dart';

import '../../models/app_user.dart';

import '../../models/app_chart.dart';
import '../../repositories/app_chart_repository.dart';

part 'app_chart_state.dart';

class AppChartCubit extends Cubit<AppChartState> {
  final AppChartRepository _appChartRepository;
  StreamSubscription _appChartsSubscription;
  StreamSubscription _appChartSubscription;

  Database db;

  AppChartCubit({
    @required AppChartRepository appChartRepository,
  })  : _appChartRepository = appChartRepository,
        super(AppChartInitial());

  void loadAppCharts({
    int userId,
    int libraryId,
  }) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appChartsSubscription?.cancel();
    _appChartsSubscription = _appChartRepository
        .charts(
      db: db,
      userId: userId,
      libraryId: libraryId,
    )
        .listen(
      (appCharts) async {
        emit(AppChartsLoaded(
          libraryId: libraryId,
          appCharts: appCharts,
        ));
      },
    );
  }

  void loadAppChart({
    @required AppUser user,
    @required int chartId,
    bool withFileData = true,
  }) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appChartSubscription?.cancel();
    _appChartSubscription = _appChartRepository
        .chart(
      db: db,
      userId: user.id,
      chartId: chartId,
    )
        .listen(
      (appChart) async {
        //
      },
    );
  }

  void addAppChart(AppChart appChart) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appChartRepository.addNew(
      db: db,
      appChart: appChart,
    );
  }

  void updateAppChart({
    @required AppChart appChart,
  }) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appChartRepository.update(
      db: db,
      appChart: appChart,
    );
  }

  void deleteAppChart(AppChart appChart) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appChartRepository.delete(
      db: db,
      appChart: appChart,
    );
  }

  @override
  Future<void> close() {
    _appChartsSubscription?.cancel();
    _appChartSubscription?.cancel();
    return super.close();
  }
}
