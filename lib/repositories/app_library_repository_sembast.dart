import 'dart:async';

import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/app_library.dart';
import 'app_library_repository.dart';

class AppLibraryRepositorySembast extends AppLibraryRepository {
  // Sembast store using Map records with int keys
  StoreRef store = intMapStoreFactory.store('libraries');

  //
  Future<void> addNew({
    @required Database db,
    @required AppLibrary appLibrary,
  }) async {
    // Store some objects
    await db.transaction((txn) async {
      await store.add(txn, appLibrary.toDocument());
    });
  }

  //
  Stream<List<AppLibrary>> libraries({
    @required Database db,
    @required int userId,
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
            (snapshot) => AppLibrary.fromSembastSnapshot(snapshot),
      )
          .toList(),
    );
  }
}
