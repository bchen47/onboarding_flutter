import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/repository/user_repository.dart';
import 'package:prueba/models/user.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

//implementación de los métodos del controller de Usuarios
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState._()) {
    on<UserStatusChanged>(_onUserStatusChanged);
    on<UserLogoutRequested>(_onUserLogoutRequested);
    on<UserLogedIn>(_onUserLoggedIn);
    _userLoginSuscription = _userRepository.status.listen(
      (status) => {add(UserStatusChanged(status))},
    );
  }

  final UserRepository _userRepository;
  late StreamSubscription<User> _userLoginSuscription;
  @override
  Future<void> close() {
    _userRepository.dispose();
    _userLoginSuscription.cancel();
    return super.close();
  }

  void _onUserLoggedIn(
    UserLogedIn event,
    Emitter<UserState> emit,
  ) async {
    _userRepository.getUser(event.token);
  }

  void _onUserStatusChanged(
    UserStatusChanged event,
    Emitter<UserState> emit,
  ) async {
    return emit(state.copyWith(user: event.status));
  }

  void _onUserLogoutRequested(
    UserLogoutRequested event,
    Emitter<UserState> emit,
  ) {
    _userRepository.logOut();
  }
}
