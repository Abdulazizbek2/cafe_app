import '../../domain/entities/meal.dart';

extension MealModelMapper on MealModel {
  Meal toEntity() {
    return Meal(
      id: id,
      name: name,
      category: category,
      instructions: instructions,
      thumbnail: thumbnail,
      price: price,
      youtube: youtube,
    );
  }
}

class MealModel {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final String price; 
  final String thumbnail;
  final String youtube;

  MealModel({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.thumbnail,
    required this.price,
    required this.youtube,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      price: json['strPrice'] ?? '0.00', // Default price
      youtube: json['strYoutube'] ?? '',
    );
  }
}




