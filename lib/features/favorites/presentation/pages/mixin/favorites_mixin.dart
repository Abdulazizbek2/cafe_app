part of "../favorites_page.dart";

mixin FavoritesMixin on State<FavoritesPage> {
  late final TabController _tabController;

  void initControllers(TickerProvider tickerProvider) {
    _tabController = TabController(
      length: 3,
      vsync: tickerProvider,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
