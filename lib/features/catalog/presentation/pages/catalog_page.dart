import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:cafe_app/core/utils/utils.dart";

part "mixin/catalog_mixin.dart";

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>
    with CatalogMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initControllers(this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Каталог"),
          titleTextStyle: context.textStyle.appBarTitle,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(AppIcons.search),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                padding: AppUtils.kPaddingHor10,
                indicatorWeight: 4,
                tabs: const <Widget>[
                  Tab(text: "Эксклюзив", height: 45),
                  Tab(text: "Фильмы", height: 45),
                  Tab(text: "ТВ", height: 45),
                  Tab(text: "Спорт", height: 45),
                  Tab(text: "Сериалы", height: 45),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(child: Text("Эксклюзив")),
            Center(child: Text("Фильмы")),
            Center(child: Text("ТВ")),
            Center(child: Text("Спорт")),
            Center(child: Text("Сериалы")),
          ],
        ),
      );
}
