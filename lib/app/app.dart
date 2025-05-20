import 'package:cafe_app/features/meals/presentation/bloc/cart/cart_bloc.dart';
import 'package:cafe_app/features/meals/presentation/bloc/meal/meal_bloc.dart';
import 'package:cafe_app/features/meals/presentation/pages/cart/cart_screen.dart';
import 'package:cafe_app/features/meals/presentation/pages/meal_screen.dart';
import 'package:cafe_app/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      home: BlocProvider(
        create: (context) => sl<MealBloc>()..add(GetCategoriesEvent()),
        child: const MealScreen(),
      ),
      routes: {
        '/cart': (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<CartBloc>(),
                ),
                BlocProvider(
                  create: (context) => sl<MealBloc>(),
                ),
              ],
              child: const CartScreen(),
            ),
      },
    );
  }
}
