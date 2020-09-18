import 'dart:async';
import 'package:meta/meta.dart';

import '../models/app_user.dart';

abstract class UserRepository {
  //
  Future<void> addNew(AppUser user);

  //
  Stream<AppUser> user({
    @required String id,
  });
}
