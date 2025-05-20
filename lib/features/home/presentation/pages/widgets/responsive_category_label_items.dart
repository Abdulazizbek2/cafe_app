import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:otp_autofill_plus/otp_autofill_plus.dart';

const _LABEL_HEIGHT = 40.0;
const CATEGORY_LABEL_BAR_HEIGHT = 50.0;

/// List of Category Items
class CategoryLabels extends StatefulWidget {
  final StringCallback onCategorySelected;
  final double outerPadding;
  final String currentCategoryId;
  final String parentCategoryId;
  final double statusBarHeight;
  final List<String> categories;

  const CategoryLabels({
    super.key,
    this.outerPadding = 20,
    required this.onCategorySelected,
    required this.currentCategoryId,
    this.parentCategoryId = '',
    required this.statusBarHeight,
    required this.categories,
  });

  @override
  CategoryLabelsState createState() => CategoryLabelsState();
}

class CategoryLabelsState extends State<CategoryLabels> {
  final ScrollController _controller = ScrollController();
  late String? _currentCategoryId;
  late double _screenWidth;

  // categoryId, categoryName
  final List<(String, String)> _categoryList = [];
  final Map<String, String> _mapChildToParent = HashMap();

  // categoryId, GlobalKey
  final HashMap<String, GlobalKey> _keys = HashMap();

  Widget _renderItemCategory({
    required BuildContext context,
    required String categoryId,
    required String categoryName,
    required GlobalKey key,
  }) {
    return GestureDetector(
      child: Container(
        key: key,
        height: _LABEL_HEIGHT,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          // border: Border.all(width: 1, color: Colors.black.withOpacity(0.05)),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
                color: _currentCategoryId == categoryId
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).textSelectionTheme.selectionHandleColor),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (_currentCategoryId != categoryId) {
          setState(() {
            _currentCategoryId = categoryId;
          });

          _makeLabelCentered(key);
        }
        widget.onCategorySelected(categoryId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listCategoryWidgets = [];
    listCategoryWidgets.add(SizedBox(width: widget.outerPadding));
    if (_categoryList.isNotEmpty) {
      for (int i = 0; i < _categoryList.length; i++) {
        final item = _categoryList[i];
        listCategoryWidgets.add(
            _renderItemCategory(context: context, categoryId: item.$1, categoryName: item.$2, key: _keys[item.$1]!));
        if (i < _categoryList.length - 1) {
          listCategoryWidgets.add(const SizedBox(width: 10));
        }
      }
    }
    listCategoryWidgets.add(SizedBox(width: widget.outerPadding));

    return ExcludeSemantics(
      child: Container(
        color: Colors.transparent,
        height: _getCategoryPanelHeight(),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: listCategoryWidgets,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  double _getCategoryPanelHeight() {
    const res = CATEGORY_LABEL_BAR_HEIGHT + 20;
    return res;
  }

  @override
  void initState() {
    super.initState();

    _currentCategoryId = widget.currentCategoryId;

    for (String cat in widget.categories) {
      _categoryList.add((cat, cat));
      _keys[cat] = GlobalKey();
    }
    _currentCategoryId = _categoryList.firstOrNull?.$1;
  }

  void selectCategoryLabels(String id) {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      if (_mapChildToParent.containsKey(id)) {
        var parentId = _mapChildToParent[id];
        if (parentId == _currentCategoryId) {
          return;
        } else {
          id = parentId!;
        }
      }

      setState(() {
        _currentCategoryId = id;
      });
      _makeLabelCentered(_keys[_currentCategoryId]!);
    });
  }

  // постараться показать ярлык по центру экрана
  void _makeLabelCentered(GlobalKey? labelKey) {
    if (labelKey == null) {
      return;
    }
    RenderBox? renderBox = labelKey.currentContext?.findRenderObject() as RenderBox;
    var labelWidth = renderBox.size.width;
    var labelXOffset = renderBox.localToGlobal(Offset.zero).dx;
    var scrollPosition = _controller.position.pixels;
    var maxScrollSize = _controller.position.maxScrollExtent;

    var newPos = labelXOffset - (_screenWidth - labelWidth) / 2 + scrollPosition;
    if (newPos < 0) {
      newPos = 0;
    }
    if (newPos > maxScrollSize) {
      newPos = maxScrollSize;
    }
    _controller.animateTo(newPos, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void didUpdateWidget(CategoryLabels oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentCategoryId = widget.currentCategoryId;

    // очистка
    _categoryList.clear();
    _mapChildToParent.clear();
    _keys.clear();
    // categoryId, categoryName

    for (var cat in widget.categories) {
      _categoryList.add((cat, cat));
      _keys[cat] = GlobalKey();
    }
    _currentCategoryId = _categoryList.firstOrNull?.$1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
