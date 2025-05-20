import "dart:ui";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "package:cafe_app/core/utils/utils.dart";

class BlurText extends StatelessWidget {
  const BlurText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: AppUtils.kBorderRadius24,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Material(
            color: const Color.fromRGBO(0, 0, 0, 0.3),
            borderRadius: AppUtils.kBorderRadius24,
            child: Padding(
              padding: AppUtils.kPaddingHor8Ver2,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
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
