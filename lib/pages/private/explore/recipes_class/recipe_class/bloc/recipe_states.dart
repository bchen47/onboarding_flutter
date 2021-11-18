part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  const RecipeState._({this.recipe = Recipe.empty});
  final Recipe recipe;
  RecipeState copyWith({Recipe? recipe}) {
    return RecipeState._(recipe: recipe ?? this.recipe);
  }

  @override
  List<Object> get props => [recipe];
}
