import 'dart:async';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  //
  Future<void> addNew(AppUser user) async {
    usersCollection.doc(user.id).set(user.toDocument());
  }

  //
  Stream<AppUser> user({
    @required String id,
  }) {
    return usersCollection.doc(id).snapshots().map(
          (snapshot) =>
              (snapshot.data() != null) ? AppUser.fromSnapshot(snapshot) : null,
        );
  }
}
