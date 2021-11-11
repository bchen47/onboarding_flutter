import 'package:prueba/src/bloc/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const HomeState()) {
    on<HomeIndexChanged>(_onIndexChange);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onIndexChange(
    HomeIndexChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(index: event.index));
  }
}
