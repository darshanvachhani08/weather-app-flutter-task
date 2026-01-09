import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/core.dart';
import 'features/weather/data/datasources/weather_local_data_source.dart';
import 'features/weather/data/datasources/weather_local_data_source_impl.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/datasources/weather_remote_data_source_impl.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/usecases/get_current_weather.dart';
import 'features/weather/domain/usecases/get_5_day_forecast.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(getCurrentWeather: sl(), get5dayForecast: sl()));

  sl.registerLazySingleton(() => LocaleCubit(sl()));
  sl.registerLazySingleton(() => ThemeCubit());

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => Get5DayForecast(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(dio: sl(), apiKey: dotenv.get('OPENWEATHER_API_KEY')),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(() => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final dio = Dio();
  dio.interceptors.add(LanguageInterceptor(sl()));
  sl.registerLazySingleton(() => dio);
}
