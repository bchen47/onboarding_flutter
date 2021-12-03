import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/repository/recipes_repository.dart';
import 'package:prueba/models/recipes.dart';
part 'recipes_events.dart';
part 'recipes_states.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc({required RecipesRepository recipesRepository})
      : _recipesRepository = recipesRepository,
        super(const RecipesState._()) {
    on<RecipesChanged>(_onLoadRecipes);
    on<GetRecipes>(_getRecipes);
    _recipesLoadedSuscription = recipesRepository.status.listen(
      (status) => {add(RecipesChanged(status.attributes))},
    );
  }

  final RecipesRepository _recipesRepository;
  late StreamSubscription<Recipes> _recipesLoadedSuscription;

  @override
  Future<void> close() {
    _recipesLoadedSuscription.cancel();
    _recipesRepository.dispose();
    return super.close();
  }

  void _onLoadRecipes(
    RecipesChanged event,
    Emitter<RecipesState> emit,
  ) async {
    emit(state.copyWith(recipes: Recipes(event.attributes)));
  }

  void _getRecipes(GetRecipes event, Emitter<RecipesState> emit) async {
    var response = _recipesRepository.getRecipes(event.token, event.category);
    response
        .then((value) => state.copyWith(recipes: Recipes(value!.attributes)));
  }
}
