import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double lat, double lon);

  Future<WeatherModel> getWeatherByCity(String cityName);

  Future<List<ForecastModel>> get5DayForecast(double lat, double lon);
}
