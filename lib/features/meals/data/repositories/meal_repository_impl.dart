import 'package:cafe_app/features/meals/data/models/category_model.dart';
import 'package:cafe_app/features/meals/domain/entities/category.dart';

import '../../domain/entities/meal.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meal_remote_data_source.dart';
import '../models/meal_model.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;

  MealRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Meal>> getMeals() async {
    final models = await remoteDataSource.fetchMeals();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Meal> getMealDetail(String id) async {
    final model = await remoteDataSource.fetchMealDetail(id);
    return model.toEntity();
  }

  @override
  Future<List<Category>> getCategories() async {
    final models = await remoteDataSource.fetchCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Meal>> getMealsByCategory(String categoryId) async {
    final models = await remoteDataSource.fetchMealsByCategory(categoryId);
    return models.map((m) => m.toEntity()).toList();
  }
}
