import "package:flutter/material.dart";

import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/l10n/app_localizations_setup.dart";
import "package:cafe_app/core/theme/themes.dart";
import "package:cafe_app/router/app_routes.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,

        /// router
        routerConfig: router,

        /// theme style
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: context.options.themeMode,

        /// locale
        locale: context.options.locale,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      );
}
