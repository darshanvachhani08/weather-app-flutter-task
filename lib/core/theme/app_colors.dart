import '../core.dart';

AppColor colors(BuildContext context) => Theme.of(context).colors;

/// To get Light and dark mode.[AppThemes]
class AppThemes {
  late ThemeData selectedColor;
  AppColor appColor = const AppColor(
    primary: Color(0xFF2196F3),
    white: Color(0xFFFFFFFF),
    transparent: Color(0x00000000),
    black: Color(0xFF000000),
    primaryBlue: Color(0xFF2196F3),
    primaryBlueLight: Color(0xFF64B5F6),
    primaryBlueDark: Color(0xFF1976D2),
    orangeAccent: Color(0xFFFF9800),
    redAccent: Color(0xFFFF5252),
    blueAccent: Color(0xFF448AFF),
    teal: Color(0xFF009688),
    temperatureOrange: Color(0xFFFF9800),
    humidityBlue: Color(0xFF2196F3),
    windTeal: Color(0xFF009688),
    backgroundLight: Color(0xFFF5F5F5),
    backgroundDark: Color(0xFF1E1E1E),
    cardBackgroundDark: Color(0xFF2C2C2C),
    progressBackground: Color(0xFFEEEEEE),
    textPrimary: Color(0xFF212121),
    textSecondary: Color(0xFF757575),
    textTertiary: Color(0xFF9E9E9E),
    textWhite: Color(0xFFFFFFFF),
    textWhite70: Color(0xB3FFFFFF),
    textWhite60: Color(0x99FFFFFF),
    grey300: Color(0xFFE0E0E0),
    grey400: Color(0xFFBDBDBD),
    grey600: Color(0xFF757575),
    grey800: Color(0xFF424242),
    mapMarkerAzure: Color(0xFF00BFFF),
    blueShade900: Color(0xFF0D47A1),
    gradientStart: Color(0xFF64B5F6),
    gradientEnd: Color(0xFF1976D2),
    errorRed: Color(0xFFD32F2F),
    darkGradientStart: Color(0xFF1A237E),
    darkGradientEnd: Color(0xFF121212),
    darkCardBackground: Color(0xFF2C2C2C),
  );

  ThemeData light({MaterialColor? theme}) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: appColor.primary,
      scaffoldBackgroundColor: appColor.white,
      dividerTheme: DividerThemeData(color: appColor.grey300, space: 1.0),
      colorScheme: ColorScheme.fromSeed(seedColor: appColor.primary, primary: appColor.primary),
      appBarTheme: AppBarTheme(
        backgroundColor: appColor.primary,
        foregroundColor: appColor.textWhite,
        iconTheme: IconThemeData(color: appColor.textWhite),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: appColor.primary.withValues(alpha: 0.2),
        selectionHandleColor: appColor.primary,
      ),
    )..addThemeConfig(appColor);
  }

  ThemeData dark({MaterialColor? theme}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: appColor.primary,
      scaffoldBackgroundColor: appColor.backgroundDark,
      dividerTheme: DividerThemeData(color: appColor.grey800, space: 1.0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: appColor.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColor.backgroundDark,
        foregroundColor: appColor.textWhite,
        iconTheme: IconThemeData(color: appColor.textWhite),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: appColor.primary,
        cursorColor: appColor.primary,
        selectionColor: appColor.primary,
      ),
    )..addThemeConfig(appColor);
  }
}

class AppColor {
  final Color primary;
  final Color white;
  final Color black;
  final Color transparent;
  final Color primaryBlue;
  final Color primaryBlueLight;
  final Color primaryBlueDark;
  final Color orangeAccent;
  final Color redAccent;
  final Color blueAccent;
  final Color teal;
  final Color temperatureOrange;
  final Color humidityBlue;
  final Color windTeal;
  final Color backgroundLight;
  final Color backgroundDark;
  final Color cardBackgroundDark;
  final Color progressBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textWhite;
  final Color textWhite70;
  final Color textWhite60;
  final Color grey300;
  final Color grey400;
  final Color grey600;
  final Color grey800;
  final Color mapMarkerAzure;
  final Color blueShade900;
  final Color gradientStart;
  final Color gradientEnd;
  final Color darkGradientStart;
  final Color darkGradientEnd;
  final Color darkCardBackground;
  final Color errorRed;

  const AppColor({
    required this.primary,
    required this.white,
    required this.transparent,
    required this.black,
    required this.primaryBlue,
    required this.primaryBlueLight,
    required this.primaryBlueDark,
    required this.orangeAccent,
    required this.redAccent,
    required this.blueAccent,
    required this.teal,
    required this.temperatureOrange,
    required this.humidityBlue,
    required this.windTeal,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.cardBackgroundDark,
    required this.progressBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textWhite,
    required this.textWhite70,
    required this.textWhite60,
    required this.grey300,
    required this.grey400,
    required this.grey600,
    required this.grey800,
    required this.mapMarkerAzure,
    required this.blueShade900,
    required this.gradientStart,
    required this.gradientEnd,
    required this.darkGradientStart,
    required this.darkGradientEnd,
    required this.darkCardBackground,
    required this.errorRed,
  });
}

extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationThemeData, AppColor> _colors = {};

  void addThemeConfig(AppColor theme) {
    _colors[inputDecorationTheme] = theme;
  }

  static AppColor? empty;

  AppColor get colors => _colors[inputDecorationTheme]!;
}
