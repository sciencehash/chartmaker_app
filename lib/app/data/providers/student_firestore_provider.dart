import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chartmaker_app/app/data/models/student.dart';
import 'package:chartmaker_app/app/data/services/student_service.dart';

class StudentFirestoreProvider extends StudentService {
  // Set collection name
  final _collectionName = 'users';

  // Firebase cloudstore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> initProvider() async {}

  /// getFirestoreUser
  Future<Student?> byId(String id) async {
    return await _db.collection(_collectionName).doc(id).get().then(
          (documentSnapshot) => Student.fromFirestoreMap(
            documentSnapshot.id,
            documentSnapshot.data()!,
          ),
        );
  }

  ///
  Stream<Student?> watchById(String id) {
    return _db.collection(_collectionName).doc(id).snapshots().map(
          (snapshot) => snapshot.data() != null
              ? Student.fromFirestoreMap(
                  snapshot.id,
                  snapshot.data()!,
                )
              : null,
        );
  }

  ///
  Future<void> add(Student student) async {
    await _db.collection(_collectionName).doc(student.id).set(
          student.toFirestoreDocument(),
        );
  }

  ///
  Future<void> update(Student student) async {
    await _db.collection(_collectionName).doc(student.id).set(
          student.toFirestoreDocument(),
        );
  }

  ///
  Future<void> removeById(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }
}
