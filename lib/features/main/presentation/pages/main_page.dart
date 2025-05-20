import "dart:ui";
import "package:flutter/material.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:go_router/go_router.dart";

class MainPage extends StatelessWidget {
  const MainPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: navigationShell.currentIndex != 0,
        onPopInvoked: (bool v) => navigationShell.goBranch(0),
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: navigationShell,
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 56,
                sigmaY: 56,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: navigationShell.currentIndex,
                unselectedItemColor: const Color(0xB39099B2),
                selectedItemColor: const Color(0xFF0ABAB5),
                selectedIconTheme: const IconThemeData(
                  color: Color(0xFF0ABAB5),
                ),
                onTap: (int index) => changeTap(index, context),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(AppIcons.home),
                    label: "Главная",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(AppIcons.gift),
                    label: "Еда",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(AppIcons.favorites),
                    label: "Избранное",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(AppIcons.user_circle),
                    label: "Профиль",
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void changeTap(
    int index,
    BuildContext context,
  ) {
    if (index == 1 || index == 0) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }
  }
}
