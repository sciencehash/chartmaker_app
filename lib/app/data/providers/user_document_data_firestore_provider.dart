import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/data/models/user_document_data.dart';
import 'package:chartmaker_app/app/data/services/user_document_data_service.dart';

class UserDocumentDataFirestoreProvider extends UserDocumentDataService {
  // Set collection name
  final _collectionName = 'userDocumentData';

  // Firebase cloudstore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> initProvider() async {}

  /// getFirestoreUser
  Future<UserDocumentData?> byId(String id) async {
    return await _db.collection(_collectionName).doc(id).get().then(
          (documentSnapshot) => UserDocumentData.fromFirestoreMap(
            documentSnapshot.id,
            documentSnapshot.data()!,
          ),
        );
  }

  ///
  Stream<UserDocumentData?> watchById(String id) {
    return _db.collection(_collectionName).doc(id).snapshots().map(
          (snapshot) => snapshot.data() != null
              ? UserDocumentData.fromFirestoreMap(
                  snapshot.id,
                  snapshot.data()!,
                )
              : null,
        );
  }

  ///
  Future<String> add(UserDocumentData userDocumentData) async {
    if (userDocumentData.id == '') {
      final doc = await _db.collection(_collectionName).add(
            userDocumentData.toFirestoreDocument(),
          );
      return doc.id;
    } else {
      await _db.collection(_collectionName).doc(userDocumentData.id).set(
            userDocumentData.toFirestoreDocument(),
          );
      return userDocumentData.id;
    }
  }

  ///
  Future<void> update(UserDocumentData userDocumentData) async {
    await _db.collection(_collectionName).doc(userDocumentData.id).update(
          userDocumentData.toFirestoreDocument(),
        );
  }

  ///
  Future<void> removeById(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }

  ///
  Future<List<UserDocumentData>> all() async {
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
          (snapshot) => UserDocumentData.fromFirestoreMap(
            snapshot.id,
            snapshot.data() as Map<dynamic, dynamic>,
          ),
        )
        .toList();
  }
}
