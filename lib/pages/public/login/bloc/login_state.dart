part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.visible = true});

  final FormzStatus status;
  final Username username;
  final Password password;
  final bool visible;

  LoginState copyWith(
      {FormzStatus? status,
      Username? username,
      Password? password,
      bool? visible}) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        visible: visible ?? this.visible);
  }

  @override
  List<Object> get props => [status, username, password, visible];
}
