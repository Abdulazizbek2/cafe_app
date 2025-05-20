import 'package:cafe_app/features/meals/domain/entities/category.dart';

import '../entities/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getMeals();
  Future<Meal> getMealDetail(String id);
  Future<List<Category>> getCategories();
  Future<List<Meal>> getMealsByCategory(String categoryId);
}
