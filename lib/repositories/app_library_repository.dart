import 'dart:async';
import 'package:meta/meta.dart';

import '../models/app_library.dart';

abstract class AppLibraryRepository {
  //
  Future<void> addNew(AppLibrary appLibrary);

  //
  Stream<List<AppLibrary>> libraries({@required String userId});
}