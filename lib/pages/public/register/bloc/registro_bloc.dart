import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:prueba/pages/public/register/models/models.dart';
import 'package:prueba/src/bloc/user_repository.dart';
part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroBloc() : super(const RegistroState()) {
    on<RegistroUsernameChanged>(_onUsernameChanged);
    on<RegistroPasswordChanged>(_onPasswordChanged);
    on<RegistroVisibilityChanged>(_onVisibilityChanged);
    on<RegistroEmailChanged>(_onEmailChanged);
    on<RegistroSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    RegistroUsernameChanged event,
    Emitter<RegistroState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onEmailChanged(
    RegistroEmailChanged event,
    Emitter<RegistroState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onVisibilityChanged(
    RegistroVisibilityChanged event,
    Emitter<RegistroState> emit,
  ) {
    emit(
      state.copyWith(visible: event.visibility),
    );
  }

  void _onPasswordChanged(
    RegistroPasswordChanged event,
    Emitter<RegistroState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    RegistroSubmitted event,
    Emitter<RegistroState> emit,
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
