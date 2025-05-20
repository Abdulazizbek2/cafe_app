import "package:cafe_app/features/meals/domain/entities/category.dart";
import "package:cafe_app/features/meals/domain/entities/meal.dart";
import "package:cafe_app/features/meals/domain/usecases/get_category.dart";
import "package:cafe_app/features/meals/domain/usecases/get_meal_detail.dart";

import "package:cafe_app/features/meals/domain/usecases/get_meals_by_category.dart";
import "package:cafe_app/features/meals/presentation/bloc/home/main_bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "meal_state.dart";

part "meal_event.dart";

class MealBloc extends Bloc<MealEvent, MealState> {
  final GetMealsByCategory getCategoryMeals;
  final GetCategory getCategories;
  final GetMealDetail getMealDetail;
  MealBloc({required this.getMealDetail, required this.getCategories, required this.getCategoryMeals})
      : super(const MealState()) {
    on<GetCategoriesEvent>(_onLoadCategory);
    on<GetCategoryMealsEvent>(_onLoadMeals);
    on<GetMealDetailEvent>(_onLoadMealDetail);
  }

  Future<void> _onLoadMeals(
    GetCategoryMealsEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(getMealStatus: Status.loading));
    try {
      final meals = await getCategoryMeals(event.categoryId);
      emit(state.copyWith(meals: meals, getMealStatus: Status.loaded));
    } catch (e, s) {
      print('Exection on get data: $e  $s');
      emit(state.copyWith(getMealStatus: Status.error));
    }
  }

  void _onLoadMealDetail(
    GetMealDetailEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(getInfoStatus: Status.loading));
    try {
      final meal = await getMealDetail(event.id);
      emit(state.copyWith(mealInfo: meal, getInfoStatus: Status.loaded));
    } catch (e) {
      emit(state.copyWith(getInfoStatus: Status.error));
    }
  }

  Future<void> _onLoadCategory(
    GetCategoriesEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(getCategoryStatus: Status.loading));
    try {
      final categories = await getCategories();
      add(GetCategoryMealsEvent(categories.first.name));
      emit(state.copyWith(categories: categories, getCategoryStatus: Status.loaded));
    } catch (e, s) {
      print('Exection on get category data: $e  $s');
      emit(state.copyWith(getCategoryStatus: Status.error));
    }
  }
}
