// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'جاذبية الطقس';

  @override
  String get searchCityHint => 'ابحث عن مدينة...';

  @override
  String get searchPlaceholder => 'ابحث عن مدينة أو استخدم GPS';

  @override
  String get errorTitle => 'عذراً!';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get humidity => 'الرطوبة';

  @override
  String get wind => 'الرياح';

  @override
  String get forecastTitle => 'توقعات 5 أيام';

  @override
  String get mapTitle => 'خريطة الطقس';

  @override
  String get temperature => 'درجة الحرارة';

  @override
  String get precipitation => 'هطول الأمطار';

  @override
  String get myLocation => 'موقعي';

  @override
  String get selectedLocation => 'الموقع المختار';

  @override
  String get tempShort => 'حرارة';

  @override
  String get fetchingWeatherData => 'جاري جلب بيانات الطقس...';

  @override
  String get appName => 'جاذبية الطقس';

  @override
  String get appTagline => 'سماءك، بياناتك';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'हिंदी (Hindi)';

  @override
  String get languageArabic => 'العربية (Arabic)';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';
}
