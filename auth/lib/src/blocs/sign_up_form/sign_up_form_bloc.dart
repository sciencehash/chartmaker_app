import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/auth_repository.dart';
import '../../utils/validators.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthRepository _authRepository;

  SignUpFormBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository, super(SignUpFormState.empty());

//  @override
//  SignUpFormState get initialState => SignUpFormState.empty();

  @override
  Stream<SignUpFormState> mapEventToState(
    SignUpFormEvent event,
  ) async* {
    if (event is SignUpFormNameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is SignUpFormEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is SignUpFormPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignUpFormSubmitted) {
      yield* _mapFormSubmittedToState(event.name, event.email, event.password);
    }
  }

  Stream<SignUpFormState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.isValidName(name),
    );
  }

  Stream<SignUpFormState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignUpFormState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpFormState> _mapFormSubmittedToState(
    String name,
    String email,
    String password,
  ) async* {
    yield SignUpFormState.loading();
    try {
      await _authRepository.signUp(
        email: email,
        password: password,
      );
      await _authRepository.updateProfile(displayName: name);
      yield SignUpFormState.success();
    } catch (_) {
      yield SignUpFormState.failure();
    }
  }
}
