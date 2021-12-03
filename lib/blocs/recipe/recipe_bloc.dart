import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/repository/recipe_repository.dart';
import 'package:prueba/models/recipe.dart';
part 'recipe_events.dart';
part 'recipe_states.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(const RecipeState._()) {
    on<RecipeChanged>(_onLoadRecipe);
    on<GetRecipe>(_getRecipe);
    _recipeLoadedSuscription = recipeRepository.status.listen(
      (status) => {add(RecipeChanged(status.attributes, status.author))},
    );
  }

  final RecipeRepository _recipeRepository;
  late StreamSubscription<Recipe> _recipeLoadedSuscription;

  @override
  Future<void> close() {
    _recipeLoadedSuscription.cancel();
    _recipeRepository.dispose();
    return super.close();
  }

  void _onLoadRecipe(
    RecipeChanged event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(recipe: Recipe(event.attributes, event.trainers)));
  }

  void _getRecipe(GetRecipe event, Emitter<RecipeState> emit) {
    Future<Recipe?> response =
        _recipeRepository.getRecipe(event.token, event.id);
    response.then((value) =>
        emit(state.copyWith(recipe: Recipe(value!.attributes, value.author))));
  }
}
