import 'dart:async';
import 'package:meta/meta.dart';

import '../models/app_document.dart';

abstract class AppDocumentRepository {
  //
  Future<void> addNew(AppDocument appDocument);

  //
  Future<void> update(AppDocument appDocument);

  //
  Future<void> delete(AppDocument appDocument);

  //
  Stream<List<AppDocument>> documents({
    @required String userId,
    @required String libraryId,
  });

  //
  Stream<AppDocument> document({
    @required String userId,
    @required String documentId,
  });
}
