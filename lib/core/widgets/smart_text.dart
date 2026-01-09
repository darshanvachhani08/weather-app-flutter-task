import '../core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';

/// SmartText - Enhanced Text widget with localization and responsive sizing
class SmartText extends StatelessWidget {
  final String? _text;
  final TextStyle? _style;
  final Color? color;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? optionalPadding;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final bool expanded;
  final bool flexible;
  final int flex;
  final bool useLocalization;

  SmartText(
    String? text, {
    super.key,
    this.color,
    TextStyle? style,
    this.fontWeight,
    this.optionalPadding,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.maxLines,
    this.onTap,
    this.expanded = false,
    this.flexible = false,
    this.flex = 1,
    this.useLocalization = true,
  }) : _text = text,
       _style = style {
    assert(!(expanded && flexible), 'expanded and flexible cannot be true at the same time');
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
    );
    TextStyle? style = _style ?? defaultStyle;

    // Merge custom style properties
    if (color != null || fontWeight != null || decoration != null) {
      style = style.merge(TextStyle(color: color, fontWeight: fontWeight, decoration: decoration));
    }

    // Get localized text if needed
    String displayText = _text ?? '';
    if (useLocalization && displayText.isNotEmpty) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) {
        // Try to get localized version if it exists in arb files
        // For now, just use the text as-is since we're using direct strings
        // In a real scenario, you'd use l10n.getString(displayText) or similar
      }
    }

    Widget child = Text(displayText, style: style, overflow: overflow, textAlign: textAlign, maxLines: maxLines);

    if (_text != null && _text.isNotEmpty && optionalPadding != null) {
      child = Padding(padding: optionalPadding!, child: child);
    }
    if (onTap != null) {
      child = GestureDetector(onTap: onTap, child: child);
    }

    if (expanded) {
      child = Expanded(flex: flex, child: child);
    } else if (flexible) {
      child = Flexible(flex: flex, child: child);
    }
    return child;
  }
}
