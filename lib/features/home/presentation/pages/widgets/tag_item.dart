import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/utils/utils.dart";

class TagItem extends StatelessWidget {
  const TagItem({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        customBorder: context.shapes.circleBorder,
        child: Material(
          color: context.color.whiteOpacity05,
          shape: context.shapes.circleBorder,
          child: Padding(
            padding: AppUtils.kPaddingHor16Ver4,
            child: Text(
              text,
              style: const TextStyle(
                height: 20 / 12,
                fontSize: 12,
                color: Color(0xFFBFBFBF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("text", text));
  }
}
