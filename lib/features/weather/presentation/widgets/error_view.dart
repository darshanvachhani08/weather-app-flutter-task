import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingXLarge),
        child: SmartColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimens.iconXLarge,
              color: AppColors.redAccent,
            ),
            SizedBox(height: AppDimens.spacingLarge),
            SmartText(
              l10n.errorTitle,
              useLocalization: false,
              style: TextStyle(
                fontSize: AppDimens.fontSizeXXLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimens.spacingMedium),
            SmartText(
              message,
              useLocalization: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimens.fontSizeMedium,
                color: theme.textTheme.bodyMedium?.color ?? AppColors.textTertiary,
              ),
            ),
            SizedBox(height: AppDimens.spacingXXLarge),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: SmartText(l10n.tryAgain, useLocalization: false),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.buttonPaddingHorizontal,
                  vertical: AppDimens.buttonPaddingVertical,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
