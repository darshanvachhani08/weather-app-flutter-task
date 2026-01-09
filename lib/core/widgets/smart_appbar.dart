import '../core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// SmartAppBar - Enhanced AppBar widget with customizable leading, title, and actions
class SmartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final bool isCenter;

  // Leading Section
  final bool isBack;
  final Widget? leadingImage;
  final Widget? leading;
  final VoidCallback? onBack;

  // Actions
  final List<Widget>? actions;
  final VoidCallback? onSearch;
  final VoidCallback? onFavorite;
  final VoidCallback? onThreeDotAction;
  final double? optionalEndSpacing;

  // Search Bar
  final bool showSearchBar;
  final VoidCallback? onSearchTap;
  final String? searchHintText;

  // Notification
  final VoidCallback? onNotification;

  // Styling
  final Color? backgroundColor;
  final double? appBarHeight;
  final EdgeInsets? padding;
  final bool isBorder;
  final MainAxisSize? mainAxisSize;
  final Color? borderColor;
  final IconThemeData? iconTheme;

  const SmartAppBar({
    this.subTitle,
    super.key,
    this.leading,
    this.title,
    this.leadingImage,
    this.actions,
    this.backgroundColor,
    this.onSearch,
    this.onFavorite,
    this.titleStyle,
    this.isCenter = false,
    this.isBack = true,
    this.appBarHeight,
    this.onBack,
    this.optionalEndSpacing,
    this.onThreeDotAction,
    this.isBorder = true,
    this.mainAxisSize,
    this.padding,
    this.showSearchBar = false,
    this.onSearchTap,
    this.onNotification,
    this.searchHintText,
    this.borderColor,
    this.iconTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor =
        backgroundColor ??
            theme.appBarTheme.backgroundColor ??
            theme.primaryColor;
    final defaultBorderColor = borderColor ?? theme.dividerColor;

    return Container(
      color: defaultBackgroundColor,
      child: SmartColumn(
        isSafeArea: true,
        height: appBarHeight,
        padding: padding,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        decoration: isBorder
            ? BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(color: defaultBorderColor),
          ),
              )
            : null,
        children: [
          SmartRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading Section
              if (leading != null) leading!,

              // Title Section (contains leading icon inside it) or Search Bar
              Expanded(
                child: showSearchBar
                    ? GestureDetector(
                        onTap: onSearchTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.paddingMedium,
                            vertical: AppDimens.spacingSmall + 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark
                                ? theme.cardColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: defaultBorderColor),
                          ),
                          child: SmartRow(
                            children: [
                              Icon(
                                Icons.search,
                                size: AppDimens.iconMedium,
                                color: theme.brightness == Brightness.dark
                                    ? Colors.white70
                                    : AppColors.textSecondary,
                              ),
                              SizedBox(width: AppDimens.spacingSmall),
                              Expanded(
                                child: SmartText(
                                  searchHintText ?? 'Search...',
                                  useLocalization: false,
                                  style: TextStyle(
                                    fontSize: AppDimens.fontSizeMedium,
                                    color: theme.brightness == Brightness.dark
                                        ? Colors.white70
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _buildTitle(theme, context, defaultBorderColor),
              ),

              // Actions Section
              ..._buildActions(context),
            ],
          ),
        ],
      ),
    );
  }

  /// Build leading icon (back button or custom image)
  Widget leadingIcon(BuildContext context, ThemeData theme, Color borderColor) {
    // Show custom leading image if provided and back button is not enabled
    if (leadingImage != null && !isBack) {
      return leadingImage!;
    }
    // Show back button if enabled
    if (isBack) {
      return SmartRow(
        onTap: onBack ?? () => context.pop(),
        padding: EdgeInsetsDirectional.only(
          start: 19.w,
          end: 12.w,
          top: 10.h,
          bottom: 10.h,
        ),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.w),
              color: theme.brightness == Brightness.dark
                  ? theme.cardColor
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            height: 40.h,
            width: 40.h,
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: AppDimens.iconMedium,
              // Back button icon should be dark on white background
              // Use text color from theme for proper contrast
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : (theme.textTheme.bodyLarge?.color ??
                  theme.colorScheme.onSurface),
            ),
          ),
        ],
      );
    }
    // Show nothing by default
    return const SizedBox.shrink();
  }

  /// Build title section with leading icon
  Widget _buildTitle(ThemeData theme, BuildContext context, Color borderColor) {
    // Use appBarTheme foregroundColor for proper contrast with appbar background
    final titleColor =
        titleStyle?.color ??
            theme.appBarTheme.foregroundColor ??
            theme.textTheme.titleLarge?.color ??
            AppColors.textPrimary;

    final defaultTitleStyle = (theme.textTheme.titleLarge ??
        TextStyle(
          fontSize: AppDimens.fontSizeXLarge,
          fontWeight: FontWeight.bold,
        ))
        .copyWith(color: titleColor);

    return SmartRow(
      mainAxisAlignment: isCenter
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isBack && leadingImage == null) SizedBox(width: 20.w),
        leadingIcon(context, theme, borderColor),
        if ((isBack || leadingImage != null) && title != null)
          SizedBox(width: 6.w),
        if (title != null)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCenter
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                SmartText(
                  title ?? "",
                  useLocalization: false,
                  textAlign: isCenter ? TextAlign.center : TextAlign.start,
                  maxLines: 1,
                  style: defaultTitleStyle.merge(titleStyle),
                  overflow: TextOverflow.ellipsis,
                ),
                if (subTitle != null)
                  SmartText(
                    subTitle ?? "",
                    useLocalization: false,
                    textAlign: isCenter ? TextAlign.center : TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    optionalPadding: EdgeInsetsDirectional.only(start: 1.h),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      // Use appBarTheme foregroundColor with reduced opacity for subtitle
                      color: theme.appBarTheme.foregroundColor
                          ?.withValues(alpha: 0.7) ??
                          (theme.brightness == Brightness.dark
                              ? Colors.white70
                              : AppColors.textSecondary),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  /// Build actions row
  List<Widget> _buildActions(BuildContext context) {
    final List<Widget> actionsList = [];
    final theme = Theme.of(context);

    // Standard action buttons (only show if search bar is not enabled)
    if (onSearch != null && !showSearchBar) {
      actionsList.add(
        _buildIconButton(
          onSearch!,
          Icons.search,
          size: AppDimens.iconMedium,
          theme: theme,
        ),
      );
    }
    if (onFavorite != null) {
      actionsList.add(
        _buildIconButton(
          onFavorite!,
          Icons.favorite_border,
          size: AppDimens.iconMedium,
          theme: theme,
        ),
      );
    }
    if (onThreeDotAction != null) {
      actionsList.add(
        _buildIconButton(
          onThreeDotAction!,
          Icons.more_vert,
          size: AppDimens.iconMedium,
          theme: theme,
        ),
      );
    }
    // Notification icon in actions
    if (onNotification != null) {
      actionsList.add(
        _buildIconButton(
          onNotification!,
          Icons.notifications_outlined,
          size: 42.w,
          theme: theme,
        ),
      );
    }

    // Custom actions
    if (actions != null) actionsList.add(SizedBox(width: 18.w));
    actionsList.addAll(actions ?? []);

    // Optional end spacing
    if (optionalEndSpacing != null) {
      actionsList.add(SizedBox(width: optionalEndSpacing));
    }

    return actionsList;
  }

  /// Build icon button
  Widget _buildIconButton(VoidCallback onTap,
      IconData icon, {
        double? size,
        required ThemeData theme,
      }) {
    final iconSize = size ?? AppDimens.iconMedium;
    // Use appBarTheme iconTheme or foregroundColor for proper contrast
    final iconColor =
        iconTheme?.color ??
            theme.appBarTheme.iconTheme?.color ??
            theme.appBarTheme.foregroundColor ??
            theme.iconTheme.color ??
            AppColors.textPrimary;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 12.w),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: iconSize,
          width: iconSize,
          child: Center(
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBarHeight ?? (showSearchBar ? 80.h : 70.h));
}
