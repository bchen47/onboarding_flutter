part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.email = const Email.pure(),
      this.visible = true});

  final FormzStatus status;
  final Username username;
  final Password password;
  final bool visible;
  final Email email;

  RegisterState copyWith(
      {FormzStatus? status,
      Username? username,
      Password? password,
      bool? visible,
      Email? email}) {
    return RegisterState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        visible: visible ?? this.visible,
        email: email ?? this.email);
  }

  @override
  List<Object> get props => [status, username, password, visible, email];
}
