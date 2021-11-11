import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/src/bloc/user_repository.dart';
import 'package:prueba/src/models/user.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState._()) {
    on<UserStatusChanged>(_onUserStatusChanged);
    on<UserLogoutRequested>(_onUserLogoutRequested);
    on<UserLogedIn>(_onUserLoggedIn);
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() {
    _userRepository.dispose();
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
    return emit(state.copyWith(user: event.status.user));
  }

  void _onUserLogoutRequested(
    UserLogoutRequested event,
    Emitter<UserState> emit,
  ) {
    // _UserRepository.logOut();
  }
}
