part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeChanged extends RecipeEvent {
  const RecipeChanged(this.attributes, this.trainers);

  final Map<String, dynamic> attributes;
  final Map<String, dynamic> trainers;

  @override
  List<Object> get props => [attributes, trainers];
}

class GetRecipe extends RecipeEvent {
  const GetRecipe(this.token, this.id);

  final String token;
  final String id;
  @override
  List<Object> get props => [token, id];
}
