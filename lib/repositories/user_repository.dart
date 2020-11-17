import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/app_user.dart';

abstract class UserRepository {
  //
  Future<void> addNew({
    @required Database db,
    @required AppUser user,
  });

  //
  Stream<AppUser> user({
    @required Database db,
    @required int id,
  });
}
