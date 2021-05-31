import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/data/services/library_service.dart';

class LibraryFirestoreProvider extends LibraryService {
  // Set collection name
  final _collectionName = 'libraries';

  // Firebase cloudstore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> initProvider() async {}

  /// getFirestoreUser
  Future<Library?> byId(String id) async {
    return await _db.collection(_collectionName).doc(id).get().then(
          (documentSnapshot) => Library.fromFirestoreMap(
            documentSnapshot.id,
            documentSnapshot.data()!,
          ),
        );
  }

  ///
  Stream<Library?> watchById(String id) {
    return _db.collection(_collectionName).doc(id).snapshots().map(
          (snapshot) => snapshot.data() != null
              ? Library.fromFirestoreMap(
                  snapshot.id,
                  snapshot.data()!,
                )
              : null,
        );
  }

  ///
  Future<String> add(Library library) async {
    if (library.id == '') {
      final doc = await _db.collection(_collectionName).add(
            library.toFirestoreDocument(),
          );
      return doc.id;
    } else {
      await _db.collection(_collectionName).doc(library.id).set(
            library.toFirestoreDocument(),
          );
      return library.id;
    }
  }

  ///
  Future<void> update(Library library) async {
    await _db.collection(_collectionName).doc(library.id).update(
          library.toFirestoreDocument(),
        );
  }

  ///
  Future<void> removeById(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }

  ///
  Future<List<Library>> all() async {
    final _authCtrl = AuthController.to;
    final uid = _authCtrl.firebaseUser.value!.uid;

    QuerySnapshot querySnapshot = await _db
        .collection(
          _collectionName,
        )
        .where('a', isEqualTo: uid)
        .get();

    return querySnapshot.docs
        .map(
          (snapshot) => Library.fromFirestoreMap(
            snapshot.id,
            snapshot.data() as Map<dynamic, dynamic>,
          ),
        )
        .toList();
  }
}
