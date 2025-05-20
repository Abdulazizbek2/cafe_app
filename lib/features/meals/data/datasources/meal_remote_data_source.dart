import 'package:cafe_app/features/meals/data/models/category_model.dart';
import 'package:dio/dio.dart';
import '../models/meal_model.dart';

class MealRemoteDataSource {
  final Dio dio;

  MealRemoteDataSource({required this.dio});

  Future<List<MealModel>> fetchMeals() async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List meals = data['meals'];
      return meals.map((json) => MealModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<MealModel> fetchMealDetail(String id) async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final meal = data['meals'][0];
      return MealModel.fromJson(meal);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/categories.php',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List categories = data['categories'];
      return categories.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<MealModel>> fetchMealsByCategory(String categoryId) async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryId',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List meals = data['meals'];
      return meals.map((json) => MealModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals by category');
    }
  }
}
