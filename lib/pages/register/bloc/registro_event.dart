part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class RegistroUsernameChanged extends RegistroEvent {
  const RegistroUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegistroPasswordChanged extends RegistroEvent {
  const RegistroPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegistroSubmitted extends RegistroEvent {
  const RegistroSubmitted();
}

class RegistroVisibilityChanged extends RegistroEvent {
  const RegistroVisibilityChanged(this.visibility);
  final bool visibility;
  @override
  List<Object> get props => [visibility];
}

class RegistroEmailChanged extends RegistroEvent {
  const RegistroEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
