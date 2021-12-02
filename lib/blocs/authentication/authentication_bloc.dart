import 'dart:async';
import 'package:prueba/providers/user_repository.dart';
import 'package:prueba/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:prueba/models/token.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationCheckAuthenticated>(_checkAuthenticated);

    on<LogIn>(_tryGetUser);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => {add(AuthenticationStatusChanged(status))},
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", event.status.token.accessToken);
        prefs.setString("refresh_token", event.status.token.refreshToken);
        prefs.setString("expires_in", event.status.token.expiresIn);
        prefs.setString("token_type", event.status.token.tokenType);
        _userRepository.getUser(event.status.token.accessToken);
        return emit(AuthenticationState.authenticated(event.status.token));
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _userRepository.logOut();
    SharedPreferences.getInstance()
        .then((SharedPreferences value) => value.clear());
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

  void _checkAuthenticated(
    AuthenticationCheckAuthenticated event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.checkAutenticated();
  }
}
