// get_meals.dart
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealsByCategory {
  final MealRepository repository;

  GetMealsByCategory({required this.repository});

  Future<List<Meal>> call(String categoryId) async {
    return await repository.getMealsByCategory(categoryId);
  }
}
