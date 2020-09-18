import 'dart:async';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_document.dart';
import 'app_document_repository.dart';

class AppDocumentRepositoryFirebase extends AppDocumentRepository {
  final appDocumentsCollection = FirebaseFirestore.instance.collection('documents');

  //
  Future<void> addNew(AppDocument appDocument) async {
    appDocumentsCollection.add(appDocument.toDocument());
  }

  //
  Future<void> update(AppDocument appDocument) async {
    appDocumentsCollection
        .doc(appDocument.id)
        .update(appDocument.toDocument());
  }

  //
  Future<void> delete(AppDocument appDocument) async {
    appDocumentsCollection.doc(appDocument.id).delete();
  }

  //
  Stream<List<AppDocument>> documents({
    @required String userId,
    @required String libraryId,
  }) {
    return appDocumentsCollection
        .where('userId', isEqualTo: userId)
        .where('libraryId', isEqualTo: libraryId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (docSnapshot) => AppDocument.fromSnapshot(docSnapshot),
              )
              .toList(),
        );
  }

  //
  Stream<AppDocument> document({
    @required String userId,
    @required String documentId,
  }) {
    return appDocumentsCollection.doc(documentId).snapshots().map(
          (snapshot) => AppDocument.fromSnapshot(snapshot),
        );
  }
}
