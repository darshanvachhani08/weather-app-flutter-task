import '../core.dart';

/// SmartCircularProgressIndicator - Enhanced CircularProgressIndicator with consistent styling
class SmartCircularProgressIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;

  const SmartCircularProgressIndicator({super.key, this.padding, this.size, this.strokeWidth = 4, this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressColor = color ?? theme.colorScheme.primary;

    Widget child = CircularProgressIndicator(color: progressColor, strokeWidth: strokeWidth, backgroundColor: backgroundColor);

    if (size != null || padding != null) {
      child = Container(
        alignment: Alignment.center,
        width: size,
        height: size,
        padding: padding ?? EdgeInsets.all(AppDimens.paddingMedium),
        child: child,
      );
    }

    return child;
  }
}
