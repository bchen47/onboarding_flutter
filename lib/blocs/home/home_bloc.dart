import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/providers/user_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const HomeState()) {
    on<HomeIndexChanged>(_onIndexChange);
    on<HomeLogedIn>(_logedIn);
  }

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
