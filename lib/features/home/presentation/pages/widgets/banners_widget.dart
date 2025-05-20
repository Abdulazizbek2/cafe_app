import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/utils/utils.dart";
import "package:cafe_app/core/widgets/animations/carousel_slider.dart";
import "package:cafe_app/features/home/presentation/pages/widgets/banner_item.dart";
import "package:cafe_app/features/home/presentation/pages/widgets/dot_progress.dart";

final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

class BannersWidget extends StatelessWidget {
  const BannersWidget({
    super.key,
    this.controller,
  });

  final CarouselSliderController? controller;

  @override
  Widget build(BuildContext context) => SliverList.list(
        children: <Widget>[
          SizedBox(
            height: context.kSize.width * 576 / 1024 + 92,
            width: context.kSize.width,
            child: CarouselSlider.builder(
              unlimitedMode: true,
              enableAutoSlider: true,
              slideTransform: slideTransforms[DateTime.now().weekday % 6],
              controller: controller,
              findChildIndexCallback: findChildIndexCallbackKeyInt,
              slideBuilder: (int index) => BannerItem(
                key: ObjectKey(index),
                index: index,
              ),
              itemCount: 6,
              onSlideChanged: (int index) => _currentPage.value = index,
            ),
          ),
          AppUtils.kGap8,
          SizedBox(
            height: 12,
            child: Center(
              child: ValueListenableBuilder<int>(
                valueListenable: _currentPage,
                builder: (_, int value, __) => ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => DotProgress(
                    key: ObjectKey(index),
                    isLoading: index == _currentPage.value % 6,
                  ),
                  findChildIndexCallback: findChildIndexCallbackKeyInt,
                  separatorBuilder: (_, __) => AppUtils.kGap8,
                  itemCount: 6,
                ),
              ),
            ),
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<CarouselSliderController?>(
        "controller",
        controller,
      ),
    );
  }
}
