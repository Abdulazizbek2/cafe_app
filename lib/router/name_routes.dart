part of "app_routes.dart";

sealed class Routes {
  Routes._();

  static const String initial = "/";

  /// Auth
  static const String confirmCode = "/confirm-code";
  static const String register = "/register";

  /// Home
  static const String home = "/home";
  static const String story = "/story";

  /// TV
  static const String meal = "/meal";

  /// Catalog
  static const String cart = "/cart'";

  /// Favorites
  static const String favorites = "/favorites";

  /// Profile
  static const String profile = "/profile";

  /// internet connection
  static const String noInternet = "/no-internet";
}
