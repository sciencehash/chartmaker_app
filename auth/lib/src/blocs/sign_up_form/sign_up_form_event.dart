part of 'sign_up_form_bloc.dart';

abstract class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();
}

class SignUpFormNameChanged extends SignUpFormEvent {
  final String name;

  const SignUpFormNameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class SignUpFormEmailChanged extends SignUpFormEvent {
  final String email;

  const SignUpFormEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class SignUpFormPasswordChanged extends SignUpFormEvent {
  final String password;

  const SignUpFormPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class SignUpFormSubmitted extends SignUpFormEvent {
  final String name;
  final String email;
  final String password;

  const SignUpFormSubmitted({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, password];

  @override
  String toString() {
    return 'Submitted { name: $name, email: $email, password: $password }';
  }
}