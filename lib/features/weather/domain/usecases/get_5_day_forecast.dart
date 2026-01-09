import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../entities/forecast.dart';
import '../repositories/weather_repository.dart';

class Get5DayForecast {
  final WeatherRepository repository;

  Get5DayForecast(this.repository);

  Future<Either<Failure, List<Forecast>>> execute(double lat, double lon) async {
    return await repository.get5DayForecast(lat, lon);
  }
}
