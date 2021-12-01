part of 'recipes_bloc.dart';

class RecipesState extends Equatable {
  const RecipesState._({this.recipes = Recipes.empty});
  final Recipes recipes;
  RecipesState copyWith({Recipes? recipes}) {
    return RecipesState._(recipes: recipes ?? this.recipes);
  }

  @override
  List<Object> get props => [recipes];
}
