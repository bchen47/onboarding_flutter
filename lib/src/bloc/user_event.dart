part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserStatusChanged extends UserEvent {
  const UserStatusChanged(
    this.status,
  );

  final UserState status;

  @override
  List<Object> get props => [status];
}

class UserLogoutRequested extends UserEvent {}

class UserLogedIn extends UserEvent {
  const UserLogedIn(
    this.token,
  );

  final String token;

  @override
  List<Object> get props => [token];
}
