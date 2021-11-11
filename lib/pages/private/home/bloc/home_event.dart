part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeIndexChanged extends HomeEvent {
  const HomeIndexChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class HomeSubmitted extends HomeEvent {
  const HomeSubmitted();
}
