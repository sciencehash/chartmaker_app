import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembast/sembast.dart';
import '../../stubs/sembast/sembast_stub.dart'
if (dart.library.io) '../../stubs/sembast/sembast_io.dart'
if (dart.library.html) '../../stubs/sembast/sembast_web.dart';

import '../../models/app_user.dart';
import '../../repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  StreamSubscription _userSubscription;

  Database db;

  UserCubit({
    @required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserInitial());

  void loadUser({int id}) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _userSubscription?.cancel();
    _userSubscription = _userRepository.user(db: db, id: id).listen(
          (user) => emit(UserLoaded(user)),
    );
  }

  void addUser(AppUser user) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _userRepository.addNew(
      db: db,
      user: user,
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
