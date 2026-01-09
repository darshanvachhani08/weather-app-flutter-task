// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather Gravity';

  @override
  String get searchCityHint => 'Search city...';

  @override
  String get searchPlaceholder => 'Search for a city or use GPS';

  @override
  String get errorTitle => 'Oops!';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get forecastTitle => '5-Day Forecast';

  @override
  String get mapTitle => 'Weather Map';

  @override
  String get temperature => 'Temperature';

  @override
  String get precipitation => 'Precipitation';

  @override
  String get myLocation => 'My Location';

  @override
  String get selectedLocation => 'Selected Location';

  @override
  String get tempShort => 'Temp';

  @override
  String get fetchingWeatherData => 'Fetching Weather Data...';

  @override
  String get appName => 'WEATHER GRAVITY';

  @override
  String get appTagline => 'Your Sky, Your Data';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'हिंदी (Hindi)';

  @override
  String get languageArabic => 'العربية (Arabic)';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';
}
