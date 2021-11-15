import 'dart:async';
import 'package:prueba/pages/private/profile/bloc/profile_repository.dart';
import 'package:prueba/pages/private/profile/models/profile.dart';
import 'package:prueba/src/models/token.dart';

import 'user_repository.dart';
import 'authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:prueba/src/models/user.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required ProfileRepository profileRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _profileRepository = profileRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<LogIn>(_tryGetUser);
    on<GetProfile>(_tryGetProfile);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => {add(AuthenticationStatusChanged(status))},
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;

  late StreamSubscription<AuthenticationStatusLogin>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(AuthenticationState.authenticated(event.status.token));
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser(
      LogIn event, Emitter<AuthenticationState> emit) async {
    try {
      final user = _userRepository.getUser(event.token);
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<Profile?> _tryGetProfile(
      GetProfile event, Emitter<AuthenticationState> emit) async {
    try {
      final profile = _profileRepository.getProfile(event.token);
      return profile;
    } catch (_) {
      return null;
    }
  }
}
