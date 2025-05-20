part of "package:cafe_app/features/home/presentation/pages/home_page.dart";

mixin HomeMixin on State<HomePage> {
  // список категорий и товаров из этих категорий
  final List _homeScreenContentData = [];
  // Category _parentCategory;
  String? parentCategoryName;
  double _statusBarHeight = 100;

  double? _screenHeight;

  String _currentCategoryId = ''; // текущая категория

  GlobalKey? _firstCachedWidget;

  bool _dontRebuildCategoryBar = false;

  final List<String> _categoryIdList = [];

  final GlobalKey<CategoryLabelsState> _categoryLabelsKey = GlobalKey();

  // список всех keys экранных элементоа в порядке расположения их на экране
  final List<GlobalKey> _screenItemsKeys = [];

  // id категории - key заголовка категории. нужно для перемотки категории по щелчку на
  // ярлыке категории
  final Map<String, GlobalKey> _categoryHeaderKeysMap = HashMap();

  // GlobalKey - id категории - нужно для определения к какой категории
  // принадлежит экранный элемент
  final Map<GlobalKey, String> _screenItemKeyCategoryMap = HashMap();

  final _controller = ScrollController();

  int? currentWarehouse;

  final CarouselSliderController _pageController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // здесь расчитываем высоту для status bar
    _statusBarHeight = MediaQueryData.fromView(window).padding.top;
    if (Platform.isIOS) {
      _statusBarHeight = _statusBarHeight * 2.0 / 3.0;
    }

    parentCategoryName = 'Каталог';

    _controller.addListener(_scrollControllerListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  _buildAndFilterScreenContentList() {
    final catWithProducts = _buildCatWithProductList();

    _buildScreenContentData(catWithProducts);
  }

  List<CatWithProducts> _buildCatWithProductList() {
    final res = <CatWithProducts>[];
    final catModel = BlocProvider.of<HomeBloc>(context, listen: false);

    for (var cat in catModel.state.categoryMap.entries) {
      if (cat.value.isEmpty) {
        continue;
      } else {
        final resItem = CatWithProducts(cat.key);
        resItem.products.addAll(cat.value);
        res.add(resItem);
      }
    }
    return res;
  }

  // строит плоский список из категорий и товаров входящих в категорию
  void _buildScreenContentData(List<CatWithProducts> catWithProducts) {
    _homeScreenContentData.clear();
    _categoryIdList.clear();

    for (var cp in catWithProducts) {
      _categoryIdList.add(cp.category);
      _homeScreenContentData.add(cp.category);
      _homeScreenContentData.addAll(cp.products);
    }
    if (_categoryIdList.isNotEmpty) {
      _currentCategoryId = _categoryIdList.first;
    }
  }

  void _scrollControllerListener() {
    _determineFirstCachedWidget();
    _determineActiveCategory();
  }

  void _determineFirstCachedWidget() {
    for (var key in _screenItemsKeys) {
      if (key.currentContext != null) {
        _firstCachedWidget = key;
        return;
      }
    }
  }

  void _determineActiveCategory() {
    if (_dontRebuildCategoryBar) {
      return;
    }

    var statusBarHeight = MediaQueryData.fromView(window).padding.top;

    var viewportTop = statusBarHeight + CATEGORY_LABEL_BAR_HEIGHT;
    var viewportBottom = (_screenHeight ?? 0) - kToolbarHeight;

    List<String> visibleCategories = _getCategoriesIdInViewport(
        scrollDirection: _controller.position.userScrollDirection, top: viewportTop, bottom: viewportBottom);

    // такое бывает когда переключились на другую страницу
    if (visibleCategories.isEmpty) {
      return;
    }
    var topCatId = visibleCategories.first;
    var bottomCatId = visibleCategories.last;

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      // скроллирование снизу вверх
      if (_currentCategoryId != topCatId) {
        _currentCategoryId = topCatId;
        _setActiveCategory(_currentCategoryId);
      }
    } else {
      // скроллирование cверху вниз
      if (topCatId != bottomCatId) {
        if (_currentCategoryId != topCatId) {
          _currentCategoryId = topCatId;
          _setActiveCategory(_currentCategoryId);
        }
      } else {
        if (_currentCategoryId != bottomCatId) {
          _currentCategoryId = bottomCatId;
          _setActiveCategory(_currentCategoryId);
        }
      }
    }
  }

  // строит список ID категорий, которые попадают в область просмотра
  List<String> _getCategoriesIdInViewport(
      {ScrollDirection scrollDirection = ScrollDirection.reverse, required double top, required double bottom}) {
    List<String> res = [];

    if (scrollDirection == ScrollDirection.reverse) {
      bool visibleBlock = false;
      // скроллирование снизу вверх
      for (var key in _screenItemsKeys) {
        if (key.currentContext == null) {
          continue;
        }
        RenderBox? rb = key.currentContext?.findRenderObject() as RenderBox?;
        Offset? ofs = rb?.globalToLocal(Offset.zero);
        var y = ofs?.dy ?? 0;
        var h = rb?.size.height ?? 0;

        if (y < 0 && (y.abs() >= top || (y.abs() + h) > top) && ((y.abs() < bottom || (y.abs() + h) <= bottom))) {
          if (_screenItemKeyCategoryMap[key]?.isNotEmpty ?? false) res.add(_screenItemKeyCategoryMap[key]!);
          visibleBlock = true;
        } else {
          if (visibleBlock) {
            break;
          }
        }
      }
    } else {
      // forward скроллирование - скроллирование сверху вних
      bool visibleBlock = false;
      // скроллирование снизу вверх
      for (var key in _screenItemsKeys) {
        if (key.currentContext == null) {
          continue;
        }
        RenderBox? rb = key.currentContext?.findRenderObject() as RenderBox?;
        Offset? ofs = rb?.globalToLocal(Offset.zero);
        var y = ofs?.dy ?? 0;
        var h = rb?.size.height ?? 0;

        // здесь в отличии от reverse скроллирования будет более жесткое условие виждимости для
        // верхнего виджета - он должен целиком попасть в видимою область

        if (y < 0 && y.abs() >= top && ((y.abs() < bottom || (y.abs() + h) <= bottom))) {
          if (_screenItemKeyCategoryMap[key]?.isNotEmpty ?? false) res.add(_screenItemKeyCategoryMap[key]!);
          visibleBlock = true;
        } else {
          if (visibleBlock) {
            break;
          }
        }
      }
    }
    return res;
  }

  void _setActiveCategory(String categoryId) {
    // var homeScreenController = Provider.of<HomeScreenProductListController>(context, listen: false);
    // homeScreenController.currentCategory = categoryId;

    CategoryLabelsState? state = _categoryLabelsKey.currentState;
    state?.selectCategoryLabels(categoryId);
  }

  List<Widget> _buildWidgetList(Map<String, List<Meal>> mapData) {
    if (_homeScreenContentData.isEmpty) {
      return [const SizedBox()];
    }
    final screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 32 - 16) / 2;

    List<Widget> res = [];
    String? catId;

    int widgetIndex = 0;
    // String weAreInCategory;
    int columnCount = 2;
    while (widgetIndex < _homeScreenContentData.length) {
      var screenItem = _homeScreenContentData[widgetIndex];

      if (screenItem is String) {
        catId = screenItem;
        // количество отображаемых колонок товаров в категории
        cardWidth = (screenWidth - 32 - 16) / columnCount;

        var key = GlobalKey();
        _screenItemsKeys.add(key);
        _categoryHeaderKeysMap[screenItem] = key;
        _screenItemKeyCategoryMap[key] = screenItem;
        _firstCachedWidget ??= key;

        var bottomInsets = 24.0;

        // if (!isSubCategory) {
        //   weAreInCategory = catId;
        //   parentCategoryId = null;
        // }

        bottomInsets = 2;

        res.add(Padding(
          key: key,
          padding: EdgeInsets.only(left: 20, top: widgetIndex == 0 ? 20 : 5, right: 20, bottom: bottomInsets),
          child: Text(
            screenItem,
            style: const TextStyle(
              fontFamily: 'Inter',
              // fontFamily: 'Songer',
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
        widgetIndex++;
      } else if (screenItem is Meal) {
        cardWidth = (screenWidth - 28 - (8 * (columnCount - 1))) / columnCount;
        var rowItems = <Widget>[];
        var bottom = 14.0;

        for (int i = 0; i < columnCount; i++) {
          if (widgetIndex + i > _homeScreenContentData.length - 1) {
            bottom = 16;
            break;
          }
          if (_homeScreenContentData[widgetIndex + i] is String) {
            bottom = 16;
            break;
          }
        }

        var key = GlobalKey();
        _screenItemsKeys.add(key);
        _screenItemKeyCategoryMap[key] = catId ?? '';

        if (columnCount == 2) {
          for (int i = 0; i < columnCount && widgetIndex < _homeScreenContentData.length; i++) {
            screenItem = _homeScreenContentData[widgetIndex];
            if (screenItem is String) {
              continue;
            }
            if (screenItem is Meal) {
              rowItems.add(Padding(
                padding: EdgeInsets.only(bottom: bottom, right: 12),
                child: SizedBox(
                  height: cardWidth * 236 / 165.5,
                  width: cardWidth,
                  child: ProductItemWidget(
                    key: ValueKey((screenItem).id),
                    meal: screenItem,
                  ),
                ),
              ));
            } else {
              i--;
            }

            widgetIndex++;
          }

          res.add(Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IntrinsicHeight(
              key: key,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: rowItems,
                children: rowItems,
              ),
            ),
          ));
        }
      } else {
        widgetIndex++;
      }
    }

    return res;
  }

  /// Здесь горизонтальный список категорий
  SliverPersistentHeader _categoryLabelsList(List<String> categories) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: CATEGORY_LABEL_BAR_HEIGHT + kToolbarHeight,
        maxHeight: CATEGORY_LABEL_BAR_HEIGHT + kToolbarHeight,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15.0,
              sigmaY: 15.0,
            ),
            child: Container(
              color: Colors.transparent,
              child: CategoryLabels(
                key: _categoryLabelsKey,
                statusBarHeight: _statusBarHeight,
                currentCategoryId: _currentCategoryId,
                onCategorySelected: _onCategorySelected,
                categories: categories,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // callback для шелчка по ярлыку категории
  void _onCategorySelected(String id) async {
    _dontRebuildCategoryBar = true;
    _determineFirstCachedWidget();
    // var homeScreenController = Provider.of<HomeScreenProductListController>(context, listen: false);
    // homeScreenController.currentCategory = id;
    // если это первая категория то все просто - перемотаем до 0
    if (id == _categoryIdList[0]) {
      _currentCategoryId = _categoryIdList[0];
      await _controller.animateTo(0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutExpo);
      _currentCategoryId = _categoryIdList[0];
    } else {
      await _makeCategoryHeaderVisible(id);
      _currentCategoryId = id;
    }
    _dontRebuildCategoryBar = false;
  }

  // Сделать виджет категории видимым и по-возможность максимально поднять его вверх
  // под список ярлыков категорий
  Future<void> _makeCategoryHeaderVisible(String categoryId) async {
    var key = _categoryHeaderKeysMap[categoryId];

    if (key == null) {
      await _controller.animateTo(0, duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
      return;
    }

    var ctx = key.currentContext;
    if (ctx != null) {
      // Самый просто случай - ярлык категории в кэше и у него существует контекст
      await Scrollable.ensureVisible(key.currentContext ?? context,
          duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
    } else {
      // виджет не в кэше и надо прокрутить список, так чтобы виджет
      // попал в кэш и затем сделать его видимым
      double? increment = _isAboveFirstCachedWidget(key) ? -(_screenHeight ?? 0) : _screenHeight;
      if (increment != null) {
        increment *= 0.8;
      }

      while (true) {
        var curPosition = _controller.position.pixels;
        await _controller.animateTo(curPosition + (increment ?? 0),
            duration: const Duration(milliseconds: 5), curve: Curves.linear);
        if (key.currentContext != null) {
          break;
        }
      }
      await Scrollable.ensureVisible(key.currentContext ?? context,
          duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
    }
  }

  // определяет, расположен ли указанный виджет выше, чем первый видимый
  // это необходимо для того, чтобы выбрать направление автоскроллирования
  // если виджет расположен выше первого видимого, то
  // приращение при автоскроллировании будет с отрицательным знаком
  bool _isAboveFirstCachedWidget(GlobalKey checkedKey) {
    for (var key in _screenItemsKeys) {
      if (key == _firstCachedWidget) {
        return false;
      }
      if (key == checkedKey) {
        return true;
      }
    }
    assert(false);
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
  }
}

class CatWithProducts {
  final String category;
  final products = <Meal>[];

  CatWithProducts(this.category);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
