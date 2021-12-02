part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class RecipesChanged extends RecipesEvent {
  const RecipesChanged(this.attributes);

  final List<Map<String, dynamic>> attributes;

  @override
  List<Object> get props => [attributes];
}

class GetRecipes extends RecipesEvent {
  const GetRecipes(this.token, this.category);

  final String token;
  final String category;
  @override
  List<Object> get props => [token, category];
}
