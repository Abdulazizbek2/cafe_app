import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/core/widgets/animations/custom_linear_progress.dart";
import "package:cafe_app/core/widgets/custom_cached_network_image.dart";
import "package:cafe_app/core/widgets/painter/dot_painter.dart";

class ContinueBrowsingWidgets extends StatefulWidget {
  const ContinueBrowsingWidgets({super.key});

  @override
  State<ContinueBrowsingWidgets> createState() =>
      _ContinueBrowsingWidgetsState();
}

class _ContinueBrowsingWidgetsState extends State<ContinueBrowsingWidgets>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      cacheExtent: 1000,
      slivers: <Widget>[
        SliverSafeArea(
          minimum: AppUtils.kPaddingAll16,
          sliver: SliverGrid.builder(
            itemCount: 16,
            itemBuilder: (_, int index) =>
                ContinueBrowsing(key: ObjectKey(index)),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 8,
              mainAxisExtent: 137,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ContinueBrowsing extends StatelessWidget {
  const ContinueBrowsing({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF343434)),
                borderRadius: AppUtils.kBorderRadius8,
              ),
            ),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: AppUtils.kBorderRadius8,
                  child: CustomCachedNetworkImage(
                    height: 94,
                    width: (context.width - 44) / 2,
                    imageUrl:
                        "https://oneplatform.uz/wp-content/uploads/2023/09/1-%D1%81%D0%B5%D1%80%D0%B8%D1%8F.jpg",
                    fit: BoxFit.cover,
                    placeholder: (_, __) => alignLogo,
                    errorWidget: (_, __, ___) => alignLogo,
                  ),
                ),
                const Positioned(
                  right: 4,
                  bottom: 14,
                  child: Text(
                    "22 мин",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Center(child: Icon(AppIcons.player_play_filled)),
                ),
                const Positioned(
                  bottom: 6,
                  left: 6,
                  right: 6,
                  child: CustomLinearProgress(
                    percent: 50,
                    isAnimate: true,
                  ),
                ),
              ],
            ),
          ),
          AppUtils.kGap6,
          const Text(
            "Nega menga uylandingiz?",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppUtils.kGap2,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "1 сезон",
                style: TextStyle(
                  color: context.color.whiteOpacity5,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppUtils.kGap4,
              const Dot(),
              AppUtils.kGap4,
              Text(
                "1 серия",
                style: TextStyle(
                  color: context.color.whiteOpacity5,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
}
