import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/app_chart.dart';

abstract class AppChartRepository {
  //
  Future<void> addNew({
    @required Database db,
    @required AppChart appChart,
  });

  //
  Future<void> update({
    @required Database db,
    @required AppChart appChart,
  });

  //
  Future<void> delete({
    @required Database db,
    @required AppChart appChart,
  });

  //
  Stream<List<AppChart>> charts({
    @required Database db,
    @required int userId,
    @required int libraryId,
  });

  //
  Stream<AppChart> chart({
    @required Database db,
    @required int userId,
    @required int chartId,
  });

  //
  Future<AppChart> onceChart({
    @required Database db,
    @required int userId,
    @required int chartId,
  });
}
