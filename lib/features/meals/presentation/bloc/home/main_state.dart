part of "main_bloc.dart";

enum MainMenu { home, tv, catalog, favorites, profile }

class HomeState extends Equatable {
  const HomeState(
      {this.menu = MainMenu.tv,
      this.meals = const [],
      this.mealInfo,
      this.categoryMap = const {},
      this.status = Status.initial,
      this.infoStatus = Status.initial});

  final MainMenu menu;
  final List<Meal> meals;
  final Map<String, List<Meal>> categoryMap;
  final Meal? mealInfo;
  final Status status;
  final Status infoStatus;

  HomeState copyWith({
    MainMenu? menu,
    List<Meal>? meals,
    Meal? mealInfo,
    Status? status,
    Status? infoStatus,
    Map<String, List<Meal>>? categoryMap,
  }) =>
      HomeState(
        menu: menu ?? this.menu,
        mealInfo: mealInfo ?? this.mealInfo,
        meals: meals ?? this.meals,
        status: status ?? this.status,
        infoStatus: infoStatus ?? this.infoStatus,
        categoryMap: categoryMap ?? this.categoryMap,
      );

  @override
  List<Object?> get props => <Object?>[menu, meals, mealInfo, status, categoryMap];
}

enum Status {
  initial,
  loading,
  loaded,
  error,
}
