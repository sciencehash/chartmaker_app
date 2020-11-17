import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/app_library.dart';

abstract class AppLibraryRepository {
  //
  Future<void> addNew({
    @required Database db,
    @required AppLibrary appLibrary,
  });

  //
  Stream<List<AppLibrary>> libraries({
    @required Database db,
    @required int userId,
  });
}
