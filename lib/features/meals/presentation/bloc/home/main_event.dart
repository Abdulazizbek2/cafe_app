part of "main_bloc.dart";

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class MainEventChangeMenu extends HomeEvent {
  const MainEventChangeMenu(this.menu);

  final MainMenu menu;

  @override
  List<Object?> get props => <Object?>[menu];
}

class LoadMealsEvent extends HomeEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadMealDetailEvent extends HomeEvent {
  final String id;

  const LoadMealDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
