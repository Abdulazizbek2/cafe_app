part of "meal_bloc.dart";

sealed class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class GetCategoryMealsEvent extends MealEvent {
  final String categoryId;

  const GetCategoryMealsEvent(this.categoryId);

  @override
  List<Object?> get props => <Object?>[categoryId];
}

class GetCategoriesEvent extends MealEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class GetMealDetailEvent extends MealEvent {
  final String id;

  const GetMealDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
