part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(
    this.status,
  );

  final AuthenticationStatusLogin status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {
  const LogIn(
    this.token,
  );

  final String token;

  @override
  List<Object> get props => [token];
}

class GetProfile extends AuthenticationEvent {
  const GetProfile(
    this.token,
  );

  final String token;

  @override
  List<Object> get props => [token];
}

class AuthenticationCheckAuthenticated extends AuthenticationEvent {}
