import "dart:collection";
import "dart:io";
import "dart:math" as math;
import "dart:ui";
import "package:cafe_app/features/home/presentation/pages/widgets/product_item.dart";
import "package:cafe_app/features/meals/domain/entities/meal.dart";
import "package:cafe_app/features/meals/presentation/bloc/home/main_bloc.dart";
import "package:flutter/material.dart";
import "package:cafe_app/core/widgets/animations/carousel_slider.dart";
import "package:flutter/rendering.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "widgets/responsive_category_label_items.dart";

part "mixin/home_mixin.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   centerTitle: false,
        //   title: const Logo(),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(AppIcons.bell),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),

        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            BlocConsumer<HomeBloc, HomeState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                _buildAndFilterScreenContentList();
              },
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == Status.loaded) {
                  return CustomScrollView(
                    controller: _controller,
                    cacheExtent: 2 * (_screenHeight ?? 200),
                    slivers: [
                      /// список категорий + AppBar
                      _categoryLabelsList(state.categoryMap.keys.toList()),

                      /// список товаров
                      SliverList(
                        delegate: SliverChildListDelegate(
                          _buildWidgetList(state.categoryMap),
                        ),
                      ),

                      const SliverGap(100)
                    ],
                  );

                  //  ListView.builder(
                  //   itemCount: state.meals.length,
                  //   itemBuilder: (context, index) {
                  //     final meal = state.meals[index];
                  //     return ListTile(
                  //       leading: Image.network(meal.thumbnail),
                  //       title: Text(meal.name),
                  //       subtitle: Text(meal.category),
                  //       onTap: () {
                  //         context.read<MainBloc2>().add(LoadMealDetailEvent(meal.id));
                  //         customModalBottomSheet(
                  //             context: context,
                  //             builder: (_, __) => BlocProvider.value(
                  //                   value: context.read<MainBloc2>(),
                  //                   child: const MealDetailBottomSheet(),
                  //                 ));
                  //       },
                  //     );
                  //   },
                  // );
                } else if (state.status == Status.error) {
                  return const Center(child: Text('Ошибка получения данных'));
                }
                return Container();
              },
            ),
            // body: CustomScrollView(
            //   slivers: <Widget>[
            // BannersWidget(
            //   key: const ObjectKey("banners"),
            //   controller: _pageController,
            // ),
            // SliverList.list(
            //   key: const ObjectKey("list"),
            //   children: <Widget>[
            //     TitleRight(
            //       title: "Разработано SalomTV",
            //       onPressed: () {},
            //     ),
            //     SizedBox(
            //       height: 190,
            //       child: ListView.separated(
            //         scrollDirection: Axis.horizontal,
            //         padding: AppUtils.kPaddingHor12,
            //         itemBuilder: (_, int index) => MovieItem(
            //           key: ObjectKey(index),
            //         ),
            //         separatorBuilder: (_, __) => AppUtils.kGap8,
            //         itemCount: 6,
            //       ),
            //     ),
            //     TitleRight(
            //       title: "Онлайн телевидение",
            //       onPressed: () {},
            //     ),
            //     const OnlineTelevisionWidgets(
            //       key: ObjectKey("onlineTelevision"),
            //     ),
            //     AppUtils.kGap16,
            //   ],
            // ),
            //   ],
            // ),
          ],
        ),
      );
}
