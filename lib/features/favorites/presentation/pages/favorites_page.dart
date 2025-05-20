import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/features/favorites/presentation/pages/widgets/continue_browsing_widgets.dart";
import "package:cafe_app/features/favorites/presentation/pages/widgets/saved_widgets.dart";

part "mixin/favorites_mixin.dart";

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with FavoritesMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initControllers(this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Избранное"),
          titleTextStyle: context.textStyle.appBarTitle,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                padding: AppUtils.kPaddingHor10,
                tabs: const <Widget>[
                  Tab(text: "Сохраненные", height: 45),
                  Tab(text: "Продолжить просмотр", height: 45),
                  Tab(text: "Вы искали", height: 45),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            SavedWidgets(),
            ContinueBrowsingWidgets(),
            Center(child: Text("Вы искали")),
          ],
        ),
      );
}
