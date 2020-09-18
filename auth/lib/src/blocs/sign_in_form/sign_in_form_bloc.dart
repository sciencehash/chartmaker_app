import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/auth_repository.dart';
import '../../utils/validators.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  AuthRepository _authRepository;

  SignInFormBloc({
    @required AuthRepository authRepository,
  })  : assert(authRepository != null),
        _authRepository = authRepository, super(SignInFormState.empty());

//  @override
//  SignInFormState get initialState => SignInFormState.empty();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    if (event is SignInFormEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is SignInFormPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignInFormAnonymouslyPressed) {
      yield* _mapSignInFormAnonymouslyPressedToState();
    } else if (event is SignInFormWithGooglePressed) {
      yield* _mapSignInFormWithGooglePressedToState();
    } else if (event is SignInFormWithCredentialsPressed) {
      yield* _mapSignInFormWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SignInFormState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignInFormState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignInFormState> _mapSignInFormAnonymouslyPressedToState() async* {
    try {
      await _authRepository.signInAnonymously();
      yield SignInFormState.success();
    } catch (_) {
      yield SignInFormState.failure();
    }
  }

  Stream<SignInFormState> _mapSignInFormWithGooglePressedToState() async* {
    try {
      await _authRepository.signInWithGoogle();
      yield SignInFormState.success();
    } catch (_) {
      yield SignInFormState.failure();
    }
  }

  Stream<SignInFormState> _mapSignInFormWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield SignInFormState.loading();
    try {
      await _authRepository.signInWithCredentials(email, password);
      yield SignInFormState.success();
    } catch (_) {
      yield SignInFormState.failure();
    }
  }
}
