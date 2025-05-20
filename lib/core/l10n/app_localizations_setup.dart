import "dart:async" show Future;
import "dart:convert" show json;

import "package:flutter/cupertino.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:flutter_localizations/flutter_localizations.dart";

part "app_localizations_delegate.dart";

part "app_localizations.dart";

class AppLocalizationsSetup {
  AppLocalizationsSetup._();

  static const List<Locale> supportedLocales = <Locale>[
    Locale("en"),
    Locale("ru"),
    Locale("uz"),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];
}
