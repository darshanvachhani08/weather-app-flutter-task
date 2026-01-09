import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/weather.dart';
import '../entities/forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(double lat, double lon);

  Future<Either<Failure, Weather>> getWeatherByCity(String cityName);

  Future<Either<Failure, List<Forecast>>> get5DayForecast(double lat, double lon);
}
