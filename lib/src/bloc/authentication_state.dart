part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown,
      this.user = User.empty,
      this.token = ""});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user, String token)
      : this._(
            status: AuthenticationStatus.authenticated,
            user: user,
            token: token);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  final AuthenticationStatus status;
  final User user;
  final String token;

  AuthenticationState copyWith(
      {User? user, String? token, AuthenticationStatus? status}) {
    return AuthenticationState._(
      user: user ?? this.user,
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, user];
}
