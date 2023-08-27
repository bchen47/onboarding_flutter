import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:prueba/validators/register.dart';
import 'package:prueba/repository/user_repository.dart';
part 'register_event.dart';
part 'register_state.dart';

//Clase que contiene la implementación de los métodos de la pantalla de registro
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterVisibilityChanged>(_onVisibilityChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onVisibilityChanged(
    RegisterVisibilityChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(visible: event.visibility),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await UserRepository.register(
            username: state.username.value,
            password: state.password.value,
            email: state.email.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (exception) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
