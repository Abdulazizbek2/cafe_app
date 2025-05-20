import 'package:cafe_app/features/meals/domain/entities/category.dart';
import '../repositories/meal_repository.dart';

class GetCategory {
  final MealRepository repository;

  GetCategory({required this.repository});

  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}
