part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  bool get stringify => true;
}

class Unauthenticated extends AuthenticationState {
  final AuthRepository authRepository;

  const Unauthenticated({
    @required this.authRepository,
  });

  @override
  List<Object> get props => [authRepository];

  @override
  bool get stringify => true;
}
