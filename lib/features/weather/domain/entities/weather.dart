import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [cityName, temperature, condition, description, iconCode, humidity, windSpeed];
}
