// get_meal_detail.dart
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealDetail {
  final MealRepository repository;

  GetMealDetail({required this.repository});

  Future<Meal> call(String id) async {
    return await repository.getMealDetail(id);
  }
}
