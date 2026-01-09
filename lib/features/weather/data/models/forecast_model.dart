import '../../domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel({required super.dateTime, required super.temperature, required super.condition, required super.iconCode});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      iconCode: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dateTime.millisecondsSinceEpoch ~/ 1000,
      'main': {'temp': temperature},
      'weather': [
        {'main': condition, 'icon': iconCode},
      ],
    };
  }
}
