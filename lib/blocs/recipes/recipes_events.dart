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
