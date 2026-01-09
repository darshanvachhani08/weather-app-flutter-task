import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../../domain/entities/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = AppTheme
        .of(context)
        .weatherCardStyle;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(style.borderRadius),
      ),
      child: Container(
        padding: EdgeInsets.all(AppDimens.paddingXLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(style.borderRadius),
          gradient: LinearGradient(
            colors: [style.gradientStart, style.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SmartColumn(
          children: [
            SmartText(
              weather.cityName,
              useLocalization: false,
              style: style.cityNameStyle,
            ),
            SizedBox(height: AppDimens.spacingMedium),
            SmartImage(
              path: '${AppConstants.iconBaseUrl}${weather.iconCode}@4x.png',
              height: AppDimens.weatherIconSize,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  SmartCircularProgressIndicator(
                    color: AppColors.textWhite,
                    size: AppDimens.weatherIconSize,
                  ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColors.textWhite),
            ),
            SmartCountUpText(
              targetValue: weather.temperature,
              suffix: '°C',
              style: style.temperatureStyle,
            ),
            SmartText(
              weather.description.toUpperCase(),
              useLocalization: false,
              style: style.descriptionStyle,
            ),
            SizedBox(height: AppDimens.spacingLarge),
            SmartRow(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoColumn(
                  context,
                  Icons.water_drop,
                  '${weather.humidity}%',
                  l10n.humidity,
                ),
                _buildInfoColumn(
                  context,
                  Icons.air,
                  '${weather.windSpeed} m/s',
                  l10n.wind,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context,
      IconData icon,
      String value,
      String label,) {
    final style = AppTheme
        .of(context)
        .weatherCardStyle;
    return SmartColumn(
      children: [
        Icon(
          icon,
          color: style.infoLabelStyle.color,
          size: AppDimens.iconMedium,
        ),
        SizedBox(height: AppDimens.spacingXSmall),
        SmartText(
          value,
          useLocalization: false,
          style: style.infoValueStyle,
        ),
        SmartText(
          label,
          useLocalization: false,
          style: style.infoLabelStyle,
        ),
      ],
    );
  }
}
