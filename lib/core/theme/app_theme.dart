library;

import '../flutter_core_imports.dart';
import 'app_style_data.dart';
import 'app_colors.dart';

//AppStyle
abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return DarkModeTheme(Theme.of(context).colors);
    }
    return LightModeTheme(Theme.of(context).colors);
  }

  AppColor get colors;
  TextStyle get inter400RegularTextStyle;
  TextStyle get inter500MediumBoldTextStyle;
  TextStyle get inter600SemiBoldTextStyle;
  TextStyle get inter700BoldTextStyle;
  PrimaryButtonStyle get primaryButtonStyle;
  TextFieldStyle get textFieldStyle;
  CustomAppBarStyle get appBarStyle;
  WeatherCardStyle get weatherCardStyle;
  ForecastListStyle get forecastListStyle;
  ErrorViewStyle get errorViewStyle;
  MapPageStyle get mapPageStyle;
}

class PrimaryButtonStyle {
  final TextStyle titleStyle;
  final TextStyle titleWhiteStyle;
  final Color activeBackgroundColor;
  final Color activeWhiteBackgroundColor;
  final Color disableBackgroundColor;
  final TextStyle disableTitleStyle;
  final Color activeImageColor;
  final Color activeWhiteImageColor;
  final Color disableImageColor;

  PrimaryButtonStyle({
    required this.titleStyle,
    required this.titleWhiteStyle,
    required this.activeBackgroundColor,
    required this.activeWhiteBackgroundColor,
    required this.disableBackgroundColor,
    required this.disableTitleStyle,
    required this.activeImageColor,
    required this.activeWhiteImageColor,
    required this.disableImageColor,
  });
}

class TextFieldStyle {
  final TextStyle textStyle;
  final Color blackColor;
  final TextStyle labelStyle;
  final TextStyle errorStyle;
  final Color textFillColor;
  final Color disabledTextFieldBorderColor;
  final Color enabledTextFieldBorderColor;
  final Color focusedTextFieldBorderColor;
  final Color errorBorderColor;
  final TextStyle hintStyle;

  TextFieldStyle({
    required this.textStyle,
    required this.blackColor,
    required this.labelStyle,
    required this.errorStyle,
    required this.textFillColor,
    required this.disabledTextFieldBorderColor,
    required this.enabledTextFieldBorderColor,
    required this.focusedTextFieldBorderColor,
    required this.errorBorderColor,
    required this.hintStyle,
  });
}

class CustomAppBarStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle backTextStyle;
  final Color borderColor;
  final Color transparentColor;

  CustomAppBarStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.backTextStyle,
    required this.borderColor,
    required this.transparentColor,
  });
}

class WeatherCardStyle {
  final Color backgroundColor;
  final Color gradientStart;
  final Color gradientEnd;
  final TextStyle cityNameStyle;
  final TextStyle temperatureStyle;
  final TextStyle descriptionStyle;
  final TextStyle infoLabelStyle;
  final TextStyle infoValueStyle;
  final double borderRadius;

  WeatherCardStyle({
    required this.backgroundColor,
    required this.gradientStart,
    required this.gradientEnd,
    required this.cityNameStyle,
    required this.temperatureStyle,
    required this.descriptionStyle,
    required this.infoLabelStyle,
    required this.infoValueStyle,
    required this.borderRadius,
  });
}

class ForecastListStyle {
  final TextStyle titleStyle;
  final TextStyle dayStyle;
  final TextStyle temperatureStyle;
  final TextStyle conditionStyle;
  final Color cardBackgroundColor;
  final double cardBorderRadius;
  final double cardWidth;
  final double cardHeight;
  final Color? borderColor;
  final bool useGlassmorphism;
  final Color? gradientStart;
  final Color? gradientEnd;

  ForecastListStyle({
    required this.titleStyle,
    required this.dayStyle,
    required this.temperatureStyle,
    required this.conditionStyle,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.cardWidth,
    required this.cardHeight,
    this.borderColor,
    this.useGlassmorphism = false,
    this.gradientStart,
    this.gradientEnd,
  });
}

class ErrorViewStyle {
  final TextStyle titleStyle;
  final TextStyle messageStyle;
  final Color iconColor;
  final Color buttonBackgroundColor;
  final TextStyle buttonTextStyle;

  ErrorViewStyle({
    required this.titleStyle,
    required this.messageStyle,
    required this.iconColor,
    required this.buttonBackgroundColor,
    required this.buttonTextStyle,
  });
}

class MapPageStyle {
  final Color backgroundColor;
  final Color appBarBackgroundColor;
  final TextStyle appBarTitleStyle;
  final Color actionButtonActiveColor;
  final Color actionButtonInactiveColor;
  final Color actionButtonIconColor;
  final Color bottomSheetBackgroundColor;
  final TextStyle bottomSheetTitleStyle;
  final TextStyle bottomSheetSubtitleStyle;
  final TextStyle bottomSheetValueStyle;
  final TextStyle bottomSheetLabelStyle;

  MapPageStyle({
    required this.backgroundColor,
    required this.appBarBackgroundColor,
    required this.appBarTitleStyle,
    required this.actionButtonActiveColor,
    required this.actionButtonInactiveColor,
    required this.actionButtonIconColor,
    required this.bottomSheetBackgroundColor,
    required this.bottomSheetTitleStyle,
    required this.bottomSheetSubtitleStyle,
    required this.bottomSheetValueStyle,
    required this.bottomSheetLabelStyle,
  });
}
