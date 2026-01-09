import 'package:dio/dio.dart';
import '../../../../core/core.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import 'weather_remote_data_source.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;
  final String apiKey;

  WeatherRemoteDataSourceImpl({required this.dio, required this.apiKey});

  @override
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}${AppConstants.weatherPath}',
      queryParameters: {'lat': lat, 'lon': lon, 'appid': apiKey, 'units': 'metric'},
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException('Failed to load weather data');
    }
  }

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}${AppConstants.weatherPath}',
      queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'},
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException('City not found or API error');
    }
  }

  @override
  Future<List<ForecastModel>> get5DayForecast(double lat, double lon) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}${AppConstants.forecastPath}',
      queryParameters: {'lat': lat, 'lon': lon, 'appid': apiKey, 'units': 'metric'},
    );

    if (response.statusCode == 200) {
      final List list = response.data['list'];
      return list.map((item) => ForecastModel.fromJson(item)).toList();
    } else {
      throw ServerException('Failed to load forecast data');
    }
  }
}
