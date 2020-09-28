import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import 'package:sembast/sembast.dart';

// import '../../repositories/local_storage_repository.dart';

import '../../models/app_user.dart';

import '../../models/app_chart.dart';
import '../../repositories/app_chart_repository.dart';

part 'app_chart_state.dart';

class AppChartCubit extends Cubit<AppChartState> {
  final AppChartRepository _appChartRepository;
  StreamSubscription _appChartsSubscription;
  StreamSubscription _appChartSubscription;

  AppChartCubit({
    @required AppChartRepository appChartRepository,
  })  : _appChartRepository = appChartRepository,
        super(AppChartInitial());

  void loadAppCharts({
    String userId,
    String libraryId,
  }) async {
    _appChartsSubscription?.cancel();
    _appChartsSubscription = _appChartRepository
        .charts(
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
    @required String chartId,
    bool withFileData = true,
  }) async {
    _appChartSubscription?.cancel();
    _appChartSubscription = _appChartRepository
        .chart(
      userId: user.id,
      chartId: chartId,
    )
        .listen(
      (appChart) async {

        // Default values, null for no changes
        int localPageNum;
        double localScale;

        // If local value is more recent of remote db values
        // if (isLocalDataMoreRecent) {
        //   // Get pageNum saved locally (null for no changes)
        //   localPageNum = await LocalStorageRepository.getChartPageNumber(
        //         localStorageDb: localStorageDb,
        //         chartId: appChart.id,
        //       ) ??
        //       null;
        //
        //   // Get scale saved locally (null for no changes)
        //   localScale = await LocalStorageRepository.getChartScale(
        //         localStorageDb: localStorageDb,
        //         chartId: appChart.id,
        //       ) ??
        //       null;
        // } else {
        //   // Use remote utcLastUpdate value
        //   localUtcLastUpdate = null;
        // }

        // emit(
        //   AppChartLoaded(
        //     appChart.copyWith(
        //       coverThumbnail: thumbnailData,
        //       fileData: fileData,
        //       pageNum: localPageNum,
        //       scale: localScale,
        //       utcLastUpdate: localUtcLastUpdate,
        //     ),
        //   ),
        // );
      },
    );
  }

  void addAppChart(AppChart appChart) async {
    _appChartRepository.addNew(appChart);
  }

  void updateAppChart({
    @required AppChart appChart,
    // @required Database localStorageDb,
  }) async {
    // Get utcLastUpdate saved locally
    // final DateTime localUtcLastUpdate =
    //     await LocalStorageRepository.getChartUtcLastUpdate(
    //           localStorageDb: localStorageDb,
    //           chartId: appChart.id,
    //         ) ??
    //         null;
    //
    // // Get pageNum saved locally
    // final localPageNum = await LocalStorageRepository.getChartPageNumber(
    //       localStorageDb: localStorageDb,
    //       chartId: appChart.id,
    //     ) ??
    //     null;
    //
    // // Get scale saved locally
    // final localScale = await LocalStorageRepository.getChartScale(
    //       localStorageDb: localStorageDb,
    //       chartId: appChart.id,
    //     ) ??
    //     null;
    //
    // // If local value is more recent of remote db values
    // if (localUtcLastUpdate != null &&
    //     localUtcLastUpdate.isAfter(appChart.utcLastUpdate)) {
    //   // Use local values in AppChart
    //   appChart = appChart.copyWith(
    //     pageNum: localPageNum,
    //     scale: localScale,
    //     utcLastUpdate: localUtcLastUpdate,
    //   );
    // }
    //
    //
    _appChartRepository.update(appChart);
  }

  void deleteAppChart(AppChart appChart) async {
    _appChartRepository.delete(appChart);
  }

  @override
  Future<void> close() {
    _appChartsSubscription?.cancel();
    _appChartSubscription?.cancel();
    return super.close();
  }
}
