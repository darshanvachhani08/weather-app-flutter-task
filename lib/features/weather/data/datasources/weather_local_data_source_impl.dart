import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/core.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import 'weather_local_data_source.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    return sharedPreferences.setString(AppConstants.cachedWeather, json.encode(weatherToCache.toJson()));
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(AppConstants.cachedWeather);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheForecast(List<ForecastModel> forecastToCache) {
    final List<String> jsonList = forecastToCache.map((f) => json.encode(f.toJson())).toList();
    return sharedPreferences.setStringList(AppConstants.cachedForecast, jsonList);
  }

  @override
  Future<List<ForecastModel>> getLastForecast() {
    final jsonList = sharedPreferences.getStringList(AppConstants.cachedForecast);
    if (jsonList != null) {
      return Future.value(jsonList.map((j) => ForecastModel.fromJson(json.decode(j))).toList());
    } else {
      throw CacheException();
    }
  }
}
