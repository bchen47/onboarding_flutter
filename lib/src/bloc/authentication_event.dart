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

class GetTrainingClasses extends AuthenticationEvent {
  const GetTrainingClasses(this.token, this.category);

  final String token;
  final String category;
  @override
  List<Object> get props => [token, category];
}

class AuthenticationCheckAuthenticated extends AuthenticationEvent {}

class GetRecipes extends AuthenticationEvent {
  const GetRecipes(this.token, this.category);

  final String token;
  final String category;
  @override
  List<Object> get props => [token, category];
}
