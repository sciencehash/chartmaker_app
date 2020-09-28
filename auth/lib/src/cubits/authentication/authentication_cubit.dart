import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationInitial());

  final AuthRepository _authRepository;

  void loadAppAuth({flutterHotReload = false}) async {
    bool isFirstLoad = true;
    try {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (isFirstLoad && !flutterHotReload) {
          isFirstLoad = false;
        } else if (user != null) {
          final name = _authRepository.getUser();
          emit(
            Authenticated(name),
          );
        } else {
          emit(
            Unauthenticated(authRepository: _authRepository),
          );
        }
      });
    } catch (e) {
      print(e);
      emit(
        Unauthenticated(authRepository: _authRepository),
      );
    }
  }

  void signIn() {
    emit(
      Authenticated(_authRepository.getUser()),
    );
  }

  void signOut() {
    emit(
      Unauthenticated(authRepository: _authRepository),
    );
    _authRepository.signOut();
  }
}
