part of "meal_bloc.dart";

enum MainMenu { home, tv, catalog, favorites, profile }

class MealState extends Equatable {
  const MealState({
    this.menu = MainMenu.tv,
    this.meals = const [],
    this.mealInfo,
    this.categoryMap = const {},
    this.categories = const [],
    this.getMealStatus = Status.initial,
    this.getCategoryStatus = Status.initial,
    this.getInfoStatus = Status.initial,
  });

  final MainMenu menu;
  final List<Meal> meals;
  final Map<String, List<Meal>> categoryMap;
  final List<Category> categories;
  final Meal? mealInfo;
  final Status getMealStatus;
  final Status getCategoryStatus;
  final Status getInfoStatus;

  MealState copyWith({
    MainMenu? menu,
    List<Meal>? meals,
    List<Category>? categories,
    Meal? mealInfo,
    Status? getMealStatus,
    Status? getCategoryStatus,
    Status? getInfoStatus,
    Map<String, List<Meal>>? categoryMap,
  }) =>
      MealState(
        menu: menu ?? this.menu,
        mealInfo: mealInfo ?? this.mealInfo,
        meals: meals ?? this.meals,
        getMealStatus: getMealStatus ?? this.getMealStatus,
        getInfoStatus: getInfoStatus ?? this.getInfoStatus,
        categoryMap: categoryMap ?? this.categoryMap,
        categories: categories ?? this.categories,
        getCategoryStatus: getCategoryStatus ?? this.getCategoryStatus,
      );

  @override
  List<Object?> get props => <Object?>[
        getMealStatus,
        menu,
        meals,
        mealInfo,
        categoryMap,
        categories,
        getCategoryStatus,
        getInfoStatus,
      ];
}
