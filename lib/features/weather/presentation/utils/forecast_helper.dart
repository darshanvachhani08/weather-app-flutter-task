import '../../domain/entities/forecast.dart';

/// Helper class for forecast-related presentation logic
/// This keeps business logic out of UI widgets
class ForecastHelper {
  ForecastHelper._();

  /// Filters forecasts to show one per day (preferably at 12:00)
  /// If no 12:00 forecasts exist, returns first 5 forecasts
  static List<Forecast> getDailyForecasts(List<Forecast> forecast) {
    // Filter to show only one forecast per day (e.g., at 12:00)
    final dailyForecasts = forecast.where((f) => f.dateTime.hour == 12).toList();

    // If empty (e.g. current day past 12), just show first 5
    return dailyForecasts.isEmpty ? forecast.take(5).toList() : dailyForecasts;
  }
}
