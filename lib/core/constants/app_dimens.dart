import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized dimension constants for the application
/// All spacing, sizes, and dimensions should reference this class
class AppDimens {
  AppDimens._();

  // Padding & Margins
  static double get paddingSmall => 8.r;

  static double get paddingMedium => 16.r;

  static double get paddingLarge => 24.r;

  static double get paddingXLarge => 32.r;

  // Icon Sizes
  static double get iconSmall => 20.r;

  static double get iconMedium => 24.r;

  static double get iconLarge => 64.r;

  static double get iconXLarge => 80.r;

  static double get iconXXLarge => 100.r;

  // Font Sizes
  static double get fontSizeSmall => 12.sp;

  static double get fontSizeMedium => 16.sp;

  static double get fontSizeLarge => 18.sp;

  static double get fontSizeXLarge => 20.sp;

  static double get fontSizeXXLarge => 24.sp;

  static double get fontSizeXXXLarge => 28.sp;

  static double get fontSizeHuge => 32.sp;

  static double get fontSizeGiant => 64.sp;

  // Spacing
  static double get spacingXSmall => 4.h;

  static double get spacingSmall => 8.h;

  static double get spacingMedium => 10.h;

  static double get spacingLarge => 20.h;

  static double get spacingXLarge => 24.h;

  static double get spacingXXLarge => 30.h;

  static double get spacingHuge => 50.h;

  // Border Radius
  static double get borderRadiusSmall => 10.r;

  static double get borderRadiusMedium => 12.r;

  static double get borderRadiusLarge => 16.r;

  static double get borderRadiusXLarge => 30.r;

  static double get borderRadiusXXLarge => 32.r;

  // Card Dimensions
  static double get cardWidth => 100.w;

  static double get cardHeight => 160.h;

  static double get weatherIconSize => 100.h;

  static double get weatherIconSizeSmall => 50.h;

  static double get weatherIconSizeMap => 64.w;

  // Button Dimensions
  static double get buttonHeight => 44.r;

  static double get buttonWidth => 44.r;

  static double get buttonPaddingHorizontal => 30.w;

  static double get buttonPaddingVertical => 12.h;

  // Animation Durations (in milliseconds)
  static const int animationDurationShort = 1500;
  static const int animationDurationMedium = 2000;
  static const int splashDelay = 3000;

  // Map Specific
  static double get mapInitialZoom => 4.0;

  static double get mapLocationZoom => 8.0;

  static double get mapTileTransparency => 0.5;

  static double get mapBottomSheetHandleWidth => 40.w;

  static double get mapBottomSheetHandleHeight => 4.h;
}
