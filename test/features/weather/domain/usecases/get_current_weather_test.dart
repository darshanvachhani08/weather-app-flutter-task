import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetCurrentWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
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

  test('should get weather from repository', () async {
    // arrange
    when(() => mockWeatherRepository.getCurrentWeather(any(), any())).thenAnswer((_) async => const Right(tWeather));
    // act
    final result = await usecase.execute(51.5074, -0.1278);
    // assert
    expect(result, const Right(tWeather));
    verify(() => mockWeatherRepository.getCurrentWeather(51.5074, -0.1278));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
