import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';
import '../datasources/weather_local_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCurrentWeather(lat, lon);
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(NetworkFailure('No internet connection and no cached data'));
      }
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeatherByCity(cityName);
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Forecast>>> get5DayForecast(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForecast = await remoteDataSource.get5DayForecast(lat, lon);
        localDataSource.cacheForecast(remoteForecast);
        return Right<Failure, List<Forecast>>(remoteForecast);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localForecast = await localDataSource.getLastForecast();
        return Right<Failure, List<Forecast>>(localForecast);
      } on CacheException {
        return Left(NetworkFailure('No internet connection and no cached forecast'));
      }
    }
  }
}
