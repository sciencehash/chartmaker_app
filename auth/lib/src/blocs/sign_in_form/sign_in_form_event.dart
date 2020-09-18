part of 'sign_in_form_bloc.dart';

abstract class SignInFormEvent extends Equatable {
  const SignInFormEvent();

  @override
  List<Object> get props => [];
}

class SignInFormEmailChanged extends SignInFormEvent {
  final String email;

  const SignInFormEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class SignInFormPasswordChanged extends SignInFormEvent {
  final String password;

  const SignInFormPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

// class SignInFormSubmitted extends SignInFormEvent {
//   final String email;
//   final String password;

//   const SignInFormSubmitted({
//     @required this.email,
//     @required this.password,
//   });

//   @override
//   List<Object> get props => [email, password];

//   @override
//   String toString() {
//     return 'Submitted { email: $email, password: $password }';
//   }
// }

class SignInFormAnonymouslyPressed extends SignInFormEvent {}

class SignInFormWithGooglePressed extends SignInFormEvent {}

class SignInFormWithCredentialsPressed extends SignInFormEvent {
  final String email;
  final String password;

  const SignInFormWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'SignInFormWithCredentialsPressed { email: $email, password: $password }';
  }
}
