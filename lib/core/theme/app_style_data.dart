import '../core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightModeTheme extends AppTheme {
  final AppColor initColors;

  LightModeTheme(this.initColors);

  @override
  AppColor get colors => initColors;

  @override
  TextStyle get inter400RegularTextStyle =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 20 / 14, color: colors.textPrimary);

  @override
  TextStyle get inter500MediumBoldTextStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.textPrimary);

  @override
  TextStyle get inter600SemiBoldTextStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 24 / 16, color: colors.textPrimary);

  @override
  TextStyle get inter700BoldTextStyle =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 28 / 18, color: colors.textPrimary);

  @override
  PrimaryButtonStyle get primaryButtonStyle => PrimaryButtonStyle(
    titleStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.white),
    titleWhiteStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.primary),
    activeBackgroundColor: colors.primary,
    activeWhiteBackgroundColor: colors.white,
    disableBackgroundColor: colors.grey400,
    disableTitleStyle: inter500MediumBoldTextStyle.copyWith(color: colors.grey600, fontSize: 16.sp),
    activeImageColor: colors.white,
    activeWhiteImageColor: colors.primary,
    disableImageColor: colors.grey600,
  );

  @override
  TextFieldStyle get textFieldStyle => TextFieldStyle(
    textStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp),
    blackColor: colors.textPrimary,
    labelStyle: inter400RegularTextStyle.copyWith(fontSize: 14.sp, color: colors.textPrimary),
    errorStyle: inter400RegularTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400, color: colors.errorRed),
    textFillColor: colors.white,
    disabledTextFieldBorderColor: colors.grey300,
    enabledTextFieldBorderColor: colors.grey300,
    focusedTextFieldBorderColor: colors.primary,
    errorBorderColor: colors.errorRed,
    hintStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: colors.textSecondary),
  );

  @override
  CustomAppBarStyle get appBarStyle => CustomAppBarStyle(
    backgroundColor: colors.primary,
    titleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textWhite),
    backTextStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp),
    borderColor: colors.grey300,
    transparentColor: colors.transparent,
  );

  @override
  WeatherCardStyle get weatherCardStyle => WeatherCardStyle(
    backgroundColor: colors.white,
    gradientStart: colors.gradientStart,
    gradientEnd: colors.gradientEnd,
    cityNameStyle: inter700BoldTextStyle.copyWith(fontSize: 28.sp, color: colors.textWhite),
    temperatureStyle: TextStyle(fontSize: 64.sp, fontWeight: FontWeight.w300, color: colors.textWhite),
    descriptionStyle: TextStyle(fontSize: 18.sp, letterSpacing: 1.2, color: colors.textWhite70),
    infoLabelStyle: TextStyle(fontSize: 12.sp, color: colors.textWhite60),
    infoValueStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300, color: colors.textWhite),
    borderRadius: 16.r,
  );

  @override
  ForecastListStyle get forecastListStyle => ForecastListStyle(
    titleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textPrimary),
    dayStyle: TextStyle(fontWeight: FontWeight.bold, color: colors.textPrimary),
    temperatureStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colors.textPrimary),
    conditionStyle: TextStyle(fontSize: 12.sp, color: colors.textSecondary),
    cardBackgroundColor: colors.white,
    cardBorderRadius: 16.r,
    cardWidth: 100.w,
    cardHeight: 160.h,
    borderColor: colors.grey300,
  );

  @override
  ErrorViewStyle get errorViewStyle => ErrorViewStyle(
    titleStyle: inter700BoldTextStyle.copyWith(fontSize: 24.sp),
    messageStyle: TextStyle(fontSize: 16.sp, color: colors.textTertiary),
    iconColor: colors.errorRed,
    buttonBackgroundColor: colors.primary,
    buttonTextStyle: inter500MediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.white),
  );

  @override
  MapPageStyle get mapPageStyle => MapPageStyle(
    backgroundColor: colors.white,
    appBarBackgroundColor: colors.primary.withValues(alpha: 0.5),
    appBarTitleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textWhite),
    actionButtonActiveColor: colors.blueAccent,
    actionButtonInactiveColor: colors.white.withValues(alpha: 0.9),
    actionButtonIconColor: colors.textPrimary,
    bottomSheetBackgroundColor: colors.white,
    bottomSheetTitleStyle: inter700BoldTextStyle.copyWith(fontSize: 24.sp),
    bottomSheetSubtitleStyle: TextStyle(fontSize: 14.sp, color: colors.grey400, fontWeight: FontWeight.w600),
    bottomSheetValueStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
    bottomSheetLabelStyle: TextStyle(fontSize: 12.sp, color: colors.grey600),
  );
}

class DarkModeTheme extends AppTheme {
  final AppColor initColors;

  DarkModeTheme(this.initColors);

  @override
  AppColor get colors => initColors;

  @override
  TextStyle get inter400RegularTextStyle =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 20 / 14, color: colors.textWhite);

  @override
  TextStyle get inter500MediumBoldTextStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.textWhite);

  @override
  TextStyle get inter600SemiBoldTextStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 24 / 16, color: colors.textWhite);

  @override
  TextStyle get inter700BoldTextStyle => TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 28 / 18, color: colors.textWhite);

  @override
  PrimaryButtonStyle get primaryButtonStyle => PrimaryButtonStyle(
    titleStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.white),
    titleWhiteStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, color: colors.primary),
    activeBackgroundColor: colors.primary,
    activeWhiteBackgroundColor: colors.white,
    disableBackgroundColor: colors.grey800,
    disableTitleStyle: inter500MediumBoldTextStyle.copyWith(color: colors.grey600, fontSize: 16.sp),
    activeImageColor: colors.white,
    activeWhiteImageColor: colors.primary,
    disableImageColor: colors.grey600,
  );

  @override
  TextFieldStyle get textFieldStyle => TextFieldStyle(
    textStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp),
    blackColor: colors.white,
    labelStyle: inter400RegularTextStyle.copyWith(fontSize: 14.sp, color: colors.textWhite70),
    errorStyle: inter400RegularTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400, color: colors.errorRed),
    textFillColor: colors.cardBackgroundDark,
    disabledTextFieldBorderColor: colors.grey800,
    enabledTextFieldBorderColor: colors.grey800,
    focusedTextFieldBorderColor: colors.primary,
    errorBorderColor: colors.errorRed,
    hintStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: colors.textWhite60),
  );

  @override
  CustomAppBarStyle get appBarStyle => CustomAppBarStyle(
    backgroundColor: colors.backgroundDark,
    titleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textWhite),
    backTextStyle: inter400RegularTextStyle.copyWith(fontSize: 16.sp),
    borderColor: colors.grey800,
    transparentColor: colors.transparent,
  );

  @override
  WeatherCardStyle get weatherCardStyle => WeatherCardStyle(
    backgroundColor: colors.cardBackgroundDark,
    gradientStart: colors.darkGradientStart,
    gradientEnd: colors.darkGradientEnd,
    cityNameStyle: inter700BoldTextStyle.copyWith(fontSize: 28.sp, color: colors.textWhite),
    temperatureStyle: TextStyle(fontSize: 64.sp, fontWeight: FontWeight.w300, color: colors.textWhite),
    descriptionStyle: TextStyle(fontSize: 18.sp, letterSpacing: 1.2, color: colors.textWhite70),
    infoLabelStyle: TextStyle(fontSize: 12.sp, color: colors.textWhite60),
    infoValueStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300, color: colors.textWhite),
    borderRadius: 16.r,
  );

  @override
  ForecastListStyle get forecastListStyle => ForecastListStyle(
    titleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textWhite),
    dayStyle: TextStyle(fontWeight: FontWeight.bold, color: colors.textWhite),
    temperatureStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colors.textWhite),
    conditionStyle: TextStyle(fontSize: 12.sp, color: colors.textWhite70),
    cardBackgroundColor: colors.cardBackgroundDark.withValues(alpha: 0.4),
    cardBorderRadius: 16.r,
    cardWidth: 100.w,
    cardHeight: 160.h,
    borderColor: colors.white.withValues(alpha: 0.15),
    useGlassmorphism: true,
    gradientStart: colors.darkGradientStart.withValues(alpha: 0.5),
    gradientEnd: colors.darkGradientEnd.withValues(alpha: 0.5),
  );

  @override
  ErrorViewStyle get errorViewStyle => ErrorViewStyle(
    titleStyle: inter700BoldTextStyle.copyWith(fontSize: 24.sp),
    messageStyle: TextStyle(fontSize: 16.sp, color: colors.textWhite70),
    iconColor: colors.errorRed,
    buttonBackgroundColor: colors.primary,
    buttonTextStyle: inter500MediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.white),
  );

  @override
  MapPageStyle get mapPageStyle => MapPageStyle(
    backgroundColor: colors.backgroundDark,
    appBarBackgroundColor: colors.backgroundDark.withValues(alpha: 0.5),
    appBarTitleStyle: inter600SemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.textWhite),
    actionButtonActiveColor: colors.blueAccent,
    actionButtonInactiveColor: colors.cardBackgroundDark.withValues(alpha: 0.9),
    actionButtonIconColor: colors.textWhite,
    bottomSheetBackgroundColor: colors.backgroundDark,
    bottomSheetTitleStyle: inter700BoldTextStyle.copyWith(fontSize: 24.sp, color: colors.textWhite),
    bottomSheetSubtitleStyle: TextStyle(fontSize: 14.sp, color: colors.grey600, fontWeight: FontWeight.w600),
    bottomSheetValueStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300, color: colors.textWhite),
    bottomSheetLabelStyle: TextStyle(fontSize: 12.sp, color: colors.grey400),
  );
}
