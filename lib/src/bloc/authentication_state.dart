part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.token = Token.empty});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(Token token)
      : this._(status: AuthenticationStatus.authenticated, token: token);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  final AuthenticationStatus status;
  final Token token;

  AuthenticationState copyWith(
      {User? user, Token? token, AuthenticationStatus? status}) {
    return AuthenticationState._(
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, token];
}
