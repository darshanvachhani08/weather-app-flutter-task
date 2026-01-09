import '../core.dart';

/// Centralized color constants for the application
/// All colors used in UI should reference this class
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryBlueLight = Color(0xFF64B5F6);
  static const Color primaryBlueDark = Color(0xFF1976D2);

  // Accent Colors
  static const Color orangeAccent = Color(0xFFFF9800);
  static const Color redAccent = Color(0xFFFF5252);
  static const Color blueAccent = Color(0xFF448AFF);
  static const Color teal = Color(0xFF009688);

  // Weather-specific Colors
  static const Color temperatureOrange = Color(0xFFFF9800);
  static const Color humidityBlue = Color(0xFF2196F3);
  static const Color windTeal = Color(0xFF009688);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color cardBackgroundDark = Color(0xFF2C2C2C);
  static const Color progressBackground = Color(0xFFEEEEEE);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textWhite70 = Color(0xB3FFFFFF);
  static const Color textWhite60 = Color(0x99FFFFFF);

  // Grey Scale
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey800 = Color(0xFF424242);

  // Map Colors
  static const Color mapMarkerAzure = Color(0xFF00BFFF);
  static const Color blueShade900 = Color(0xFF0D47A1);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF64B5F6);
  static const Color gradientEnd = Color(0xFF1976D2);
}
