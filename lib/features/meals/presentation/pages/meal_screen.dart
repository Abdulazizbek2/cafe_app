import 'dart:ui';
import 'package:cafe_app/features/home/presentation/pages/widgets/product_item.dart';
import 'package:cafe_app/features/meals/presentation/bloc/home/main_bloc.dart';
import 'package:cafe_app/features/meals/presentation/bloc/meal/meal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _scrollController;
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();

    _isCollapsed = false;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        if (!_isCollapsed) {
          setState(() {
            _isCollapsed = true;
          });
        }
      } else {
        if (_isCollapsed) {
          setState(() {
            _isCollapsed = false;
          });
        }
      }
    });
    // _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('E-Commerce App'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.shopping_cart),
      //       onPressed: () {
      //         context.pushNamed(Routes.cart);
      //       },
      //     ),
      //   ],
      // ),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (_tabController == null && state.getCategoryStatus == Status.loaded) {
            _tabController = TabController(length: state.categories.length, vsync: this);

            _tabController?.addListener(() {
              if (_tabController?.indexIsChanging == true) {
                context.read<MealBloc>().add(GetCategoryMealsEvent(state.categories[_tabController!.index].name));
              }
            });
          }
          return Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                    image: state.categories.isNotEmpty && _tabController != null
                        ? DecorationImage(
                            image: NetworkImage(state.categories[_tabController!.index].thumbnail),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          )
                        : null,
                    color: Colors.black.withAlpha((0.16 * 255).toInt())),
              ),

              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 20,
                ),
                child: Material(
                  color: Colors.black.withAlpha((0.16 * 255).toInt()),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        primary: false,
                        toolbarHeight: kToolbarHeight + kTextTabBarHeight,
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        title: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: _isCollapsed ? 20 : 0,
                              sigmaY: _isCollapsed ? 20 : 0,
                            ),
                            child: SizedBox(
                              height: kToolbarHeight + kTextTabBarHeight,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: (state.getCategoryStatus == Status.loaded)
                                    ? TabBar(
                                        controller: _tabController,
                                        isScrollable: true, // Add this
                                        indicator: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.black.withAlpha((0.5 * 255).toInt()),
                                        tabs: [
                                          for (int i = 0; i < state.categories.length; i++)
                                            Tab(
                                              icon: Text(
                                                state.categories[i].name,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                        ],
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        expandedHeight: 300.0,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          stretchModes: const [
                            StretchMode.fadeTitle,
                            StretchMode.zoomBackground,
                          ],
                          // title: const Text('ГЛАВА', style: TextStyle(color: Colors.white)),
                          background: state.categories.isNotEmpty && _tabController != null
                              ? SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: kToolbarHeight + kTextTabBarHeight),
                                    child: Image.network(
                                      state.categories[_tabController!.index].thumbnail,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomCenter,
                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                        'assets/images/background.jpg',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/background.jpg',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                        ),
                        shape: const Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                      if (state.getMealStatus == Status.loaded && state.categories.isNotEmpty && _tabController != null)
                        SliverPadding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              state.categories[_tabController!.index].name,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      if (state.getMealStatus == Status.loading || state.getMealStatus == Status.error)
                        SliverFillRemaining(
                            child: Center(
                                child: (state.getMealStatus == Status.error)
                                    ? const Text('Error loading meals')
                                    : const CircularProgressIndicator()))
                      else
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverGrid.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 165.5 / 236,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: state.meals.length,
                            itemBuilder: (context, index) {
                              final meal = state.meals[index];
                              return ProductItemWidget(key: ValueKey(meal.id), meal: meal);
                            },
                          ),
                        ),
                      const SliverGap(
                        100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
