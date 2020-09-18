import 'dart:async';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_library.dart';
import 'app_library_repository.dart';

class AppLibraryRepositoryFirebase extends AppLibraryRepository {
  final appLibrariesCollection = FirebaseFirestore.instance.collection('libraries');

  //
  Future<void> addNew(AppLibrary appLibrary) async {
    appLibrariesCollection.add(appLibrary.toDocument());
  }

  //
  Stream<List<AppLibrary>> libraries({@required String userId}) {
    return appLibrariesCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (docSnapshot) => AppLibrary.fromSnapshot(docSnapshot),
              )
              .toList(),
        );
  }
}
