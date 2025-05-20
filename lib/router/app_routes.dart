import "package:cafe_app/features/meals/presentation/bloc/cart/cart_bloc.dart";
import "package:cafe_app/features/meals/presentation/bloc/home/main_bloc.dart";
import "package:cafe_app/features/meals/presentation/bloc/meal/meal_bloc.dart";
import "package:cafe_app/features/meals/presentation/pages/cart/cart_screen.dart";
import "package:cafe_app/features/meals/presentation/pages/meal_screen.dart";
import "package:chuck_interceptor/chuck.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:cafe_app/core/connectivity/network_info.dart";
import "package:cafe_app/core/local_source/local_source.dart";
import "package:cafe_app/features/favorites/presentation/pages/favorites_page.dart";
import "package:cafe_app/features/home/presentation/pages/home_page.dart";
import "package:cafe_app/features/main/presentation/pages/main_page.dart";
import "package:cafe_app/features/others/presentation/pages/internet_connection/internet_connection_page.dart";
import "package:cafe_app/features/others/presentation/pages/splash/splash_page.dart";

import "package:cafe_app/injector_container.dart";
import "package:go_router/go_router.dart";
import "package:package_info_plus/package_info_plus.dart";

part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final PackageInfo packageInfo = sl<PackageInfo>();
final NetworkInfo networkInfo = sl<NetworkInfo>();
final LocalSource localSource = sl<LocalSource>();

final Chuck chuck = Chuck(showNotification: false, navigatorKey: rootNavigatorKey);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.noInternet,
      name: Routes.noInternet,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const InternetConnectionPage(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (
        _,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) =>
          BlocProvider<HomeBloc>(
        key: state.pageKey,
        create: (_) => sl<HomeBloc>()..add(LoadMealsEvent()),
        child: MainPage(
          key: state.pageKey,
          navigationShell: navigationShell,
        ),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (_, __) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.meal,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.meal,
              name: Routes.meal,
              builder: (_, __) => BlocProvider(
                create: (context) => sl<MealBloc>()..add(GetCategoriesEvent()),
                child: const MealScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.favorites,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.favorites,
              name: Routes.favorites,
              builder: (_, __) => const FavoritesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (_, __) => const HomePage(),
            ),
          ],
        ),
      ],
    ),

    // cart screen
    GoRoute(
      path: Routes.cart,
      name: Routes.cart,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<CartBloc>(),
        child: const CartScreen(),
      ),
    ),

    /// home features
    // GoRoute(
    //   path: Routes.story,
    //   name: Routes.story,
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (_, __) => const StoryPage(),
    // ),
  ],
);
