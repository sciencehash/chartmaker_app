import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/app_chart.dart';
import 'app_chart_repository.dart';

class AppChartRepositorySembast extends AppChartRepository {
  // Sembast store using Map records with String keys
  StoreRef store = intMapStoreFactory.store('charts');

  //
  Future<void> addNew({
    @required Database db,
    @required AppChart appChart,
  }) async {
    // Store some objects
    await db.transaction((txn) async {
      await store.add(txn, appChart.toDocument());
    });
  }

  //
  Future<void> update({
    @required Database db,
    @required AppChart appChart,
  }) async {
    // Update some objects
    await db.transaction((txn) async {
      await store.update(
        txn,
        appChart.toDocument(),
        finder: Finder(
          filter: Filter.byKey(appChart.id),
        ),
      );
    });
  }

  //
  Future<void> delete({
    @required Database db,
    @required AppChart appChart,
  }) async {
    // appChartsCollection.doc(appChart.id).delete();

    // Update some objects
    await db.transaction((txn) async {
      await store.delete(
        txn,
        finder: Finder(
          filter: Filter.byKey(appChart.id),
        ),
      );
    });
  }

  //
  Stream<List<AppChart>> charts({
    @required Database db,
    @required int userId,
    @required int libraryId,
  }) {
    // Track query changes
    QueryRef query = store.query(
      finder: Finder(
        filter: Filter.equals('userId', userId),
      ),
    );

    //
    return query.onSnapshots(db).map(
          (snapshots) => snapshots
              .map(
                (snapshot) => AppChart.fromSembastSnapshot(snapshot),
              )
              .toList(),
        );
  }

  //
  Stream<AppChart> chart({
    @required Database db,
    @required int userId,
    @required int chartId,
  }) {
    // Track query changes
    QueryRef query = store.query(
      finder: Finder(
        filter: Filter.byKey(chartId),
      ),
    );

    //
    return query.onSnapshots(db).map(
          (snapshots) => AppChart.fromSembastSnapshot(snapshots.first),
        );
  }

  //
  Future<AppChart> onceChart({
    @required Database db,
    @required int userId,
    @required int chartId,
  }) async {
    return AppChart.fromSembastSnapshot(
      // await store.record(chartId).getSnapshot(db),
      await store.findFirst(
        db,
        finder: Finder(
          filter: Filter.and([
            Filter.byKey(chartId),
            Filter.equals('userId', userId),
          ]),
        ),
      ),
    );
  }
}
