import 'package:cached_network_image/cached_network_image.dart';
import '../core.dart';

/// SmartImage - Enhanced image widget supporting network images with consistent styling
class SmartImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final double? size;
  final BoxFit? fit;
  final BorderRadiusGeometry? imageBorderRadius;
  final Color? color;
  final Color? backgroundColor;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? inkwellBorderRadius;
  final BoxBorder? border;
  final bool isMemCacheEnabled;
  final BoxShape shape;
  final Clip clipBehavior;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  const SmartImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.size,
    this.fit = BoxFit.cover,
    this.imageBorderRadius,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.padding,
    this.margin,
    this.inkwellBorderRadius,
    this.border,
    this.isMemCacheEnabled = true,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.decoration,
    this.alignment,
    this.placeholder,
    this.errorWidget,
  });

  /// Safe conversion helper to prevent NaN/Infinity toInt errors
  int? _safeToInt(double? value) {
    if (value == null || !value.isFinite || value <= 0) return null;
    return value.round();
  }

  /// Check if path is a network URL
  bool get _isNetworkUrl => path.startsWith('http://') || path.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final double? finalHeight = size ?? height;
    final double? finalWidth = size ?? width;
    Widget child = const SizedBox.shrink();

    final defaultDecoration = BoxDecoration(borderRadius: imageBorderRadius, border: border, color: backgroundColor, shape: shape);

    // Handle empty or invalid path
    if (path.isEmpty) {
      child = Container(
        height: finalHeight,
        width: finalWidth,
        padding: padding,
        margin: margin,
        clipBehavior: Clip.hardEdge,
        decoration: decoration ?? defaultDecoration,
        child: Icon(Icons.image_not_supported, size: finalHeight ?? finalWidth ?? AppDimens.iconLarge, color: AppColors.textTertiary),
      );
    } else if (_isNetworkUrl) {
      // Network image
      child = CachedNetworkImage(
        matchTextDirection: false,
        memCacheWidth: isMemCacheEnabled ? _safeToInt(finalWidth) : null,
        memCacheHeight: isMemCacheEnabled ? _safeToInt(finalHeight) : null,
        height: finalHeight,
        width: finalWidth,
        fit: fit,
        imageUrl: path,
        placeholder: placeholder ?? (context, url) => Center(child: SmartCircularProgressIndicator(size: finalHeight ?? finalWidth ?? 50)),
        errorWidget:
            errorWidget ??
            (context, url, error) => Container(
              height: finalHeight,
              width: finalWidth,
              decoration: defaultDecoration,
              child: Icon(Icons.error_outline, size: finalHeight ?? finalWidth ?? AppDimens.iconLarge, color: AppColors.textTertiary),
            ),
      );
    } else {
      // Asset image (fallback)
      child = Image.asset(
        path,
        height: finalHeight,
        width: finalWidth,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          if (errorWidget != null) {
            // Call errorWidget with adapted signature
            return errorWidget!(context, path, error);
          }
          return Container(
            height: finalHeight,
            width: finalWidth,
            decoration: defaultDecoration,
            child: Icon(Icons.error_outline, size: finalHeight ?? finalWidth ?? AppDimens.iconLarge, color: AppColors.textTertiary),
          );
        },
      );
    }

    // Apply container styling if needed
    if (finalHeight != null ||
        finalWidth != null ||
        padding != null ||
        margin != null ||
        decoration != null ||
        alignment != null ||
        border != null ||
        imageBorderRadius != null) {
      child = Container(
        height: finalHeight,
        width: finalWidth,
        padding: padding,
        margin: margin,
        clipBehavior: clipBehavior,
        alignment: alignment,
        decoration: decoration ?? BoxDecoration(borderRadius: imageBorderRadius, border: border, color: backgroundColor, shape: shape),
        child: child,
      );
    }

    // Apply color filter if needed (for network images, this is limited)
    if (color != null && child is CachedNetworkImage) {
      // Note: CachedNetworkImage doesn't support color filter directly
      // You'd need to wrap it or use a different approach
    }

    return onTap != null ? InkWell(onTap: onTap, borderRadius: inkwellBorderRadius, child: child) : child;
  }
}
