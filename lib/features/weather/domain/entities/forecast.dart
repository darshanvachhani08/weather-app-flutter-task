import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final DateTime dateTime;
  final double temperature;
  final String condition;
  final String iconCode;

  const Forecast({required this.dateTime, required this.temperature, required this.condition, required this.iconCode});

  @override
  List<Object?> get props => [dateTime, temperature, condition, iconCode];
}
