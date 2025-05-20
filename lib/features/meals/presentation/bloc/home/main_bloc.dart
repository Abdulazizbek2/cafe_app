import "package:cafe_app/features/meals/domain/entities/meal.dart";
import "package:cafe_app/features/meals/domain/usecases/get_meal_detail.dart";
import "package:cafe_app/features/meals/domain/usecases/get_meals.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "main_state.dart";

part "main_event.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMeals getMeals;
  final GetMealDetail getMealDetail;
  HomeBloc({required this.getMeals, required this.getMealDetail}) : super(const HomeState()) {
    on<MainEventChangeMenu>(_onMainEventChangeMenu);
    on<LoadMealsEvent>(_onLoadMeals);
    on<LoadMealDetailEvent>(_onLoadMealDetail);
  }

  void _onMainEventChangeMenu(
    MainEventChangeMenu event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(menu: event.menu));
  }

  Future<void> _onLoadMeals(
    LoadMealsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final meals = await getMeals();
      Map<String, List<Meal>> res = {};
      for (var item in meals) {
        if (res[item.category]?.isNotEmpty ?? false) {
          res[item.category]?.add(item);
        } else {
          res[item.category] = [item];
        }
      }
      emit(state.copyWith(categoryMap: res, meals: meals, status: Status.loaded));
    } catch (e, s) {
      print('Exection on get data: $e  $s');
      emit(state.copyWith(status: Status.error));
    }
  }

  void _onLoadMealDetail(
    LoadMealDetailEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(infoStatus: Status.loading));
    try {
      final meal = await getMealDetail(event.id);
      emit(state.copyWith(mealInfo: meal, infoStatus: Status.loaded));
    } catch (e) {
      emit(state.copyWith(infoStatus: Status.error));
    }
  }
}
