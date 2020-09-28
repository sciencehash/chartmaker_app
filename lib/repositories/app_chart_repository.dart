import 'dart:async';
import 'package:meta/meta.dart';

import '../models/app_chart.dart';

abstract class AppChartRepository {
  //
  Future<void> addNew(AppChart appChart);

  //
  Future<void> update(AppChart appChart);

  //
  Future<void> delete(AppChart appChart);

  //
  Stream<List<AppChart>> charts({
    @required String userId,
    @required String libraryId,
  });

  //
  Stream<AppChart> chart({
    @required String userId,
    @required String chartId,
  });

  //
  Future<AppChart> onceChart({
    @required String userId,
    @required String chartId,
  });
}
