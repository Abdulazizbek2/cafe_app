// ignore_for_file: discarded_futures

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/core/widgets/buttons/custom_button.dart";
import "package:cafe_app/core/widgets/custom_cached_network_image.dart";
import "package:cafe_app/features/home/presentation/pages/widgets/tag_item.dart";
import "package:cafe_app/router/app_routes.dart";
import "package:go_router/go_router.dart";

class BannerItem extends StatelessWidget {
  const BannerItem({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CustomCachedNetworkImage(
                height: context.kSize.width * 576 / 1024,
                imageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/sample-bloc-5b8b9.appspot.com/o/banner.webp?alt=media",
                placeholder: (_, __) => alignLogo,
                errorWidget: (_, __, ___) => alignLogo,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: CustomButton(
                  height: 40,
                  onPressed: () {
                    context.pushNamed(Routes.story);
                  },
                  label: const Text("Смотреть"),
                  rightIcon: const Icon(AppIcons.player_play_filled),
                ),
              ),
              const Positioned(
                left: 16,
                bottom: 16,
                child: Text("Serjan Bratan"),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppUtils.kPaddingAll16,
              itemBuilder: (_, int index) => const TagItem(text: "Сериал"),
              separatorBuilder: (_, __) => AppUtils.kGap8,
              itemCount: 6,
            ),
          ),
          const Padding(
            padding: AppUtils.kPaddingHor16,
            child: Text(
              "Авторитетный алматинский рэкетир, пролежав в коме 23 года,"
              " неожиданно приходит в сознание. К своему ужасу он "
              "осознает, что на дворе 2021 год, его дети выросли, "
              "сам он постарел, а мир изменился до неузнаваемости. "
              "Теперь ему надо адаптироваться к реальности и наладить"
              " отношения с семьей.",
              maxLines: 2,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty("index", index));
  }
}
