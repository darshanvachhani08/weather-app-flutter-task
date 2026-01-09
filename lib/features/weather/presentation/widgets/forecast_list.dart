import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../../domain/entities/forecast.dart';
import '../utils/forecast_helper.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayList = ForecastHelper.getDailyForecasts(forecast);
    final style = AppTheme
        .of(context)
        .forecastListStyle;

    return SmartColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.spacingSmall,
          ),
          child: SmartText(
            l10n.forecastTitle,
            useLocalization: false,
            style: style.titleStyle,
          ),
        ),
        SizedBox(
          height: style.cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingSmall),
            itemCount: displayList.length,
            itemBuilder: (context, index) {
              final item = displayList[index];
              final cardChild = Container(
                width: style.cardWidth,
                padding: EdgeInsets.all(AppDimens.fontSizeSmall),
                decoration: BoxDecoration(
                  color: style.gradientStart != null ? null : style.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(style.cardBorderRadius),
                  border: style.borderColor != null
                      ? Border.all(color: style.borderColor!)
                      : null,
                  gradient: style.gradientStart != null && style.gradientEnd != null
                      ? LinearGradient(
                    colors: [style.gradientStart!, style.gradientEnd!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                ),
                child: SmartColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartText(
                      DateFormat(
                        'EEE',
                        Localizations
                            .localeOf(context)
                            .languageCode,
                      ).format(item.dateTime),
                      useLocalization: false,
                      style: style.dayStyle,
                    ),
                    SmartImage(
                      path: '${AppConstants.iconBaseUrl}${item.iconCode}.png',
                      height: AppDimens.weatherIconSizeSmall,
                      fit: BoxFit.contain,
                    ),
                    SmartCountUpText(
                      targetValue: item.temperature,
                      suffix: '°',
                      decimalPlaces: 0,
                      style: style.temperatureStyle,
                    ),
                    SmartText(
                      item.condition,
                      useLocalization: false,
                      style: style.conditionStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingSmall,
                  vertical: AppDimens.spacingXSmall,
                ),
                child: style.useGlassmorphism
                    ? ClipRRect(
                  borderRadius:
                  BorderRadius.circular(style.cardBorderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: cardChild,
                  ),
                )
                    : Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(style.cardBorderRadius),
                  ),
                  child: cardChild,
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppDimens.spacingHuge),
      ],
    );
  }
}
