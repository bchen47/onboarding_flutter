import 'package:prueba/src/bloc/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/src/bloc/user_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const HomeState()) {
    on<HomeIndexChanged>(_onIndexChange);
    on<HomeLogedIn>(_logedIn);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  void _onIndexChange(
    HomeIndexChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(index: event.index));
  }

  void _logedIn(HomeLogedIn event, Emitter<HomeState> emit) async {
    _userRepository.getUser(event.token);
  }
}
