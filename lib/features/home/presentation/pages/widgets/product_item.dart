import 'dart:ui';

import 'package:cafe_app/core/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:cafe_app/features/meals/domain/entities/meal.dart';
import 'package:cafe_app/features/meals/presentation/bloc/meal/meal_bloc.dart';
import 'package:cafe_app/features/meals/presentation/pages/meal_detail_sheet.dart';
import 'package:cafe_app/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2 - 50;
    return GestureDetector(
      onTap: () {
        customModalBottomSheet(
            context: context,
            builder: (_, scrollController) => BlocProvider.value(
                  value: sl<MealBloc>()..add(GetMealDetailEvent(meal.id)),
                  child: MealDetailBottomSheet(scrollController: scrollController),
                ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 58, sigmaY: 58),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha((0.24 * 255).toInt()),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(meal.thumbnail, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: width,
                            child: Text(
                              meal.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ошибка: функция добавления не реализована'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha((0.2 * 255).toInt()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add, size: 17, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                '${meal.price} монет',
                                style: const TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
