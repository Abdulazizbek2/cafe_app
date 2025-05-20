part of "../splash_page.dart";

mixin SplashMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    // ignore: discarded_futures
    RemoteConfigService.isCallCheckAppVersion(context).then(
      ((AppUpdate, String, String) value) async {
        if (value.$1 != AppUpdate.none) {
          await appUpdateBottomSheet(
            isForceUpdate: value.$1 == AppUpdate.forceUpdate,
          ).then((_) => nextToNavigation());
        } else {
          nextToNavigation();
        }
      },
    );
  }

  void nextToNavigation() {
    if (!mounted) {
      return;
    }
    context.goNamed(Routes.home);
    return;
  }

  Future<void> appUpdateBottomSheet({
    required bool isForceUpdate,
  }) async {
    await customModalBottomSheet<bool>(
      context: context,
      enableDrag: false,
      builder: (_, ScrollController? controller) => AppUpdateBottomSheetWidget(
        isForceUpdate: isForceUpdate,
        onTap: () async {
          await launchUrl(
            Uri.parse(Constants.appLink),
            mode: LaunchMode.externalApplication,
          ).then(
            (bool value) async {
              if (!mounted) {
                return;
              }
              nextToNavigation();
            },
          );
        },
      ),
    );
  }
}
