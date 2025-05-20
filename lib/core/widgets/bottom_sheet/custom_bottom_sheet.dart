import "package:cafe_app/core/theme/themes.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:cafe_app/core/extension/extension.dart";

Future<T?> customCupertinoModalPopup<T>(
  BuildContext context, {
  required void Function() actionOne,
  required void Function() actionTwo,
  String title = "",
  String actionTitleOne = "",
  String actionTitleTwo = "",
}) async =>
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text(title),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: actionOne,
            child: Text(actionTitleOne),
          ),
          CupertinoActionSheetAction(
            onPressed: actionTwo,
            child: Text(actionTitleTwo),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

typedef WidgetScrollBuilder = Widget Function(
  BuildContext context,
  ScrollController? controller,
);

Future<T?> customModalBottomSheet<T>({
  required BuildContext context,
  required WidgetScrollBuilder builder,
  bool isScrollControlled = true,
  bool enableDrag = false,
}) async =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: Colors.white.withAlpha((0.90 * 255).toInt()),
      constraints: BoxConstraints(
        maxHeight: context.kSize.height * 0.9,
        minHeight: context.kSize.height * 0.8,
      ),
      builder: (_) {
        if (isScrollControlled) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            maxChildSize: 1,
            minChildSize: 0.8,
            expand: false,
            snap: false,
            builder: (BuildContext context, ScrollController controller) => builder(context, controller),
          );
        } else {
          return builder(context, null);
        }
      },
    );
