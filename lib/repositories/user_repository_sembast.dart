import 'dart:async';
import 'package:meta/meta.dart';

import 'package:sembast/sembast.dart';

import '../models/app_user.dart';
import 'user_repository.dart';

class UserRepositorySembast extends UserRepository {
  // Sembast store using Map records with String keys
  StoreRef store = intMapStoreFactory.store('users');

  //
  Future<void> addNew({
    @required Database db,
    @required AppUser user,
  }) async {
    // usersCollection.doc(user.id).set(user.toDocument());

    // Store some objects
    await db.transaction((txn) async {
      await store.add(txn, user.toDocument());
    });
  }

  //
  Stream<AppUser> user({
    @required Database db,
    @required int id,
  }) {
    // Track query changes
    QueryRef query = store.query(
      finder: Finder(
        filter: Filter.byKey(id),
      ),
    );

    //
    return query.onSnapshots(db).map(
          (snapshots) => AppUser.fromSembastSnapshot(snapshots.first),
    );

    // return usersCollection.doc(id).snapshots().map(
    //       (snapshot) =>
    //           (snapshot.data() != null) ? AppUser.fromSnapshot(snapshot) : null,
    //     );
  }
}