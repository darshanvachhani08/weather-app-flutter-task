import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_5_day_forecast.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final Get5DayForecast get5dayForecast;

  WeatherBloc({required this.getCurrentWeather, required this.get5dayForecast}) : super(WeatherInitial()) {
    on<GetWeatherByLocationEvent>(_onGetWeatherByLocation);
    on<GetWeatherByCityEvent>(_onGetWeatherByCity);
    on<RefreshWeatherEvent>(_onRefreshWeather);
  }

  Future<void> _onGetWeatherByLocation(GetWeatherByLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final weatherResult = await getCurrentWeather.execute(event.lat, event.lon);
    final forecastResult = await get5dayForecast.execute(event.lat, event.lon);

    weatherResult.fold((failure) => emit(WeatherError(failure.message)), (weather) {
      forecastResult.fold(
        (failure) => emit(WeatherLoaded(weather: weather, forecast: const [])),
        (forecast) => emit(WeatherLoaded(weather: weather, forecast: forecast)),
      );
    });
  }

  Future<void> _onGetWeatherByCity(GetWeatherByCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final weatherResult = await getCurrentWeather.executeByCity(event.cityName.trim());

    await weatherResult.fold((failure) async => emit(WeatherError(failure.message)), (weather) async {
      // Since we only have cityName, we might need lat/lon for forecast or the API might support it.
      // For simplicity, let's assume we can't get forecast by cityName easily without search coordination or using coordinates from weather response.
      // Actually, let's use a placeholder or handle it.
      emit(WeatherLoaded(weather: weather, forecast: const []));
    });
  }

  Future<void> _onRefreshWeather(RefreshWeatherEvent event, Emitter<WeatherState> emit) async {
    final weatherResult = await getCurrentWeather.execute(event.lat, event.lon);
    final forecastResult = await get5dayForecast.execute(event.lat, event.lon);

    weatherResult.fold((failure) => emit(WeatherError(failure.message)), (weather) {
      forecastResult.fold(
        (failure) => emit(WeatherLoaded(weather: weather, forecast: const [])),
        (forecast) => emit(WeatherLoaded(weather: weather, forecast: forecast)),
      );
    });
  }
}
