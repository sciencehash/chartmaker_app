import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chartmaker_app/app/data/models/app_user.dart';
import 'package:chartmaker_app/app/data/services/app_user_service.dart';

class AppUserFirestoreProvider extends AppUserService {
  // Set collection name
  final _collectionName = 'users';

  // Firebase cloudstore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> initProvider() async {}

  /// getFirestoreUser
  Future<AppUser?> byId(String id) async {
    return await _db.collection(_collectionName).doc(id).get().then(
          (documentSnapshot) => AppUser.fromFirestoreMap(
            documentSnapshot.id,
            documentSnapshot.data()!,
          ),
        );
  }

  ///
  Stream<AppUser?> watchById(String id) {
    return _db.collection(_collectionName).doc(id).snapshots().map(
          (snapshot) => snapshot.data() != null
              ? AppUser.fromFirestoreMap(
                  snapshot.id,
                  snapshot.data()!,
                )
              : null,
        );
  }

  ///
  Future<void> add(AppUser appUser) async {
    await _db.collection(_collectionName).doc(appUser.id).set(
          appUser.toFirestoreDocument(),
        );
  }

  ///
  Future<void> update(AppUser appUser) async {
    await _db.collection(_collectionName).doc(appUser.id).set(
          appUser.toFirestoreDocument(),
        );
  }

  ///
  Future<void> removeById(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }
}
