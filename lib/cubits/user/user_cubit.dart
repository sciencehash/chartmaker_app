import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/app_user.dart';
import '../../repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  StreamSubscription _userSubscription;

  UserCubit({
    @required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserInitial());

  void loadUser({String id}) async {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.user(id: id).listen(
          (user) => emit(UserLoaded(user)),
        );
  }

  void addUser(AppUser user) async {
    _userRepository.addNew(user);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
