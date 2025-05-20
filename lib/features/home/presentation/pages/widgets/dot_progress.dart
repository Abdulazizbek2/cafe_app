import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "package:cafe_app/core/widgets/animations/simple_circular_progress_bar.dart";

class DotProgress extends StatelessWidget {
  const DotProgress({
    required this.isLoading, super.key,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          AnimatedContainer(
            margin: const EdgeInsets.all(3),
            duration: const Duration(milliseconds: 500),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isLoading
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 0.5),
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            width: 12,
            height: 12,
            child: Visibility(
              visible: isLoading,
              child: const SimpleCircularProgressBar(
                animationDuration: 5,
                size: 12,
                backStrokeWidth: 1,
                progressStrokeWidth: 1,
                progressColors: <Color>[Colors.white],
                fullProgressColor: Colors.white,
                mergeMode: true,
              ),
            ),
          ),
        ],
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>("isLoading", isLoading));
  }
}
