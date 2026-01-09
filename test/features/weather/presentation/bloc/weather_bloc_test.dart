import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_5_day_forecast.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}

class MockGet5DayForecast extends Mock implements Get5DayForecast {}

void main() {
  late WeatherBloc bloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockGet5DayForecast mockGet5DayForecast;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    mockGet5DayForecast = MockGet5DayForecast();
    bloc = WeatherBloc(getCurrentWeather: mockGetCurrentWeather, get5dayForecast: mockGet5DayForecast);
  });

  const tWeather = Weather(
    cityName: 'London',
    temperature: 20.0,
    condition: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    humidity: 50,
    windSpeed: 5.0,
  );

  test('initial state should be WeatherInitial', () {
    expect(bloc.state, equals(WeatherInitial()));
  });

  test('should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully', () async {
    // arrange
    when(() => mockGetCurrentWeather.execute(any(), any())).thenAnswer((_) async => const Right(tWeather));
    when(() => mockGet5DayForecast.execute(any(), any())).thenAnswer((_) async => const Right([]));

    // assert later
    final expected = [WeatherLoading(), const WeatherLoaded(weather: tWeather, forecast: [])];
    expectLater(bloc.stream, emitsInOrder(expected));

    // act
    bloc.add(const GetWeatherByLocationEvent(51.5074, -0.1278));
  });
}
