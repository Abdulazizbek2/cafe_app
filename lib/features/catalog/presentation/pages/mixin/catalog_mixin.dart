part of "../catalog_page.dart";

mixin CatalogMixin on State<CatalogPage> {
  late final TabController _tabController;

  void initControllers(TickerProvider tickerProvider) {
    _tabController = TabController(
      length: 5,
      vsync: tickerProvider,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
