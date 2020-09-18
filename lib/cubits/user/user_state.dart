part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final AppUser user;

  const UserLoaded([this.user]);

  @override
  List<Object> get props => [user];

  @override
  bool get stringify => true;
}
