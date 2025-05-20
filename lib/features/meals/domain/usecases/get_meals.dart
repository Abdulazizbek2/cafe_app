// get_meals.dart
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMeals {
  final MealRepository repository;

  GetMeals({required this.repository});

  Future<List<Meal>> call() async {
    return await repository.getMeals();
  }
}
