import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(double lat, double lon) async {
    return await repository.getCurrentWeather(lat, lon);
  }

  Future<Either<Failure, Weather>> executeByCity(String cityName) async {
    return await repository.getWeatherByCity(cityName);
  }
}
