import "package:flutter/material.dart";
import "package:cafe_app/core/extension/extension.dart";

import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/core/widgets/blur_text.dart";
import "package:cafe_app/core/widgets/custom_cached_network_image.dart";

class OnlineTelevisionWidgets extends StatelessWidget {
  const OnlineTelevisionWidgets({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: (context.width - 40) / 3 + 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppUtils.kPaddingHor12,
          findChildIndexCallback: findChildIndexCallbackKeyInt,
          itemBuilder: (_, int index) => OnlineTelevisionItem(
            key: ObjectKey(index),
          ),
          separatorBuilder: (_, __) => AppUtils.kGap8,
          itemCount: 6,
        ),
      );
}

class OnlineTelevisionItem extends StatelessWidget {
  const OnlineTelevisionItem({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: (context.width - 40) / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipRRect(
                  borderRadius: AppUtils.kBorderRadius8,
                  child: CustomCachedNetworkImage(
                    imageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/sample-bloc-5b8b9.appspot.com/o/movie_photo%20(1).webp?alt=media",
                    width: context.width / 3 - 20,
                    height: context.width / 3 - 20,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => alignLogo,
                    errorWidget: (_, __, ___) => alignLogo,
                  ),
                ),
                const Positioned(
                  top: -4,
                  left: -4,
                  child: BlurText(text: "Бесплатно"),
                ),
                Positioned(
                  left: 8,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFF08B451),
                      borderRadius: AppUtils.kBorderRadius4,
                    ),
                    child: const Text(
                      "HD",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppUtils.kGap8,
            const Text(
              "МатчТВ",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}
