import 'package:cafe_app/features/meals/presentation/bloc/home/main_bloc.dart';
import 'package:cafe_app/features/meals/presentation/bloc/meal/meal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailBottomSheet extends StatefulWidget {
  final ScrollController? scrollController;
  const MealDetailBottomSheet({super.key, required this.scrollController});

  @override
  State<MealDetailBottomSheet> createState() => _MealDetailBottomSheetState();
}

class _MealDetailBottomSheetState extends State<MealDetailBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        if (state.getInfoStatus == Status.loaded) {
          final meal = state.mealInfo;
          return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(meal?.thumbnail ?? ''),
                    ),
                    Text(
                      meal?.name ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    Text(
                      meal?.category ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        meal?.instructions ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    if (meal?.youtube.isNotEmpty ?? false)
                      ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(meal?.youtube ?? ''));
                        },
                        child: const Text('Смотреть видео'),
                      ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
