import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();

  Future<void> cacheWeather(WeatherModel weatherToCache);

  Future<List<ForecastModel>> getLastForecast();

  Future<void> cacheForecast(List<ForecastModel> forecastToCache);
}
