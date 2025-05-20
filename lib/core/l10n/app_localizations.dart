part of "app_localizations_setup.dart";

final class AppLocalizations {
  AppLocalizations({
    required this.locale,
  });

  final Locale locale;

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  late Map<String, String> _localizedValues = <String, String>{};

  String translate(String key, {Map<String, String>? namedArgs}) {
    if (_localizedValues.isNotEmpty) {
      if (namedArgs != null) {
        String text = _localizedValues[key] ?? key;
        namedArgs.forEach(
          (String key, String value) {
            text = text.replaceAll("{$key}", value);
          },
        );
        return text;
      }
      return _localizedValues[key] ?? key;
    }
    return "";
  }

  Future<void> load() async {
    final String jsonContent = await rootBundle.loadString(
      "assets/locale/${locale.languageCode}.json",
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonContent);
    _localizedValues = jsonMap.map<String, String>(
      (String key, value) => MapEntry<String, String>(key, value.toString()),
    );
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();
}
