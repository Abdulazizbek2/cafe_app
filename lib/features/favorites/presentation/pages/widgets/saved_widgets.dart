import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/core/widgets/custom_cached_network_image.dart";
import "package:cafe_app/core/widgets/painter/dot_painter.dart";

class SavedWidgets extends StatefulWidget {
  const SavedWidgets({super.key});

  @override
  State<SavedWidgets> createState() => _SavedWidgetsState();
}

class _SavedWidgetsState extends State<SavedWidgets>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverSafeArea(
          minimum: AppUtils.kPaddingAll16,
          sliver: SliverGrid.builder(
            itemCount: 16,
            findChildIndexCallback: findChildIndexCallbackKeyInt,
            itemBuilder: (_, int index) => SavedItem(key: ObjectKey(index)),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 8,
              mainAxisExtent: 190,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SavedItem extends StatelessWidget {
  const SavedItem({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: AppUtils.kBorderRadius8,
                child: CustomCachedNetworkImage(
                  height: 152,
                  width: (context.width - 48) / 3,
                  imageUrl:
                      "https://images.justwatch.com/poster/311294596/s718/kung-fu-panda-4.jpg",
                  placeholder: (_, __) => alignLogo,
                  errorWidget: (_, __, ___) => alignLogo,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 0,
                top: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: const ShapeDecoration(
                    color: Color(0xFFAA00A3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  child: const Text(
                    "9,0",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    "+16",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: IconButton(
                  onPressed: () {},
                  constraints: AppUtils.kBoxConstraints24,
                  style: context.shapes.favoriteButtonStyle,
                  icon: const Icon(AppIcons.favorites_fill),
                  iconSize: 16,
                ),
              ),
            ],
          ),
          AppUtils.kGap6,
          const Text(
            "Побег из Шоушенка",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppUtils.kGap2,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Фильм",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: context.color.whiteOpacity5,
                ),
              ),
              AppUtils.kGap4,
              const Dot(),
              AppUtils.kGap4,
              Text(
                "1994",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: context.color.whiteOpacity5,
                ),
              ),
            ],
          ),
        ],
      );
}
