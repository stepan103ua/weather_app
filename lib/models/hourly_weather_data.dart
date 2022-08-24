import 'package:weather_app/constants.dart';

class HourlyWeatherData {
  final String time;
  final DateTime dateTime;
  final double temperatureAsDouble;
  final String iconPath;
  final double pressure;
  final double windSpeed;
  final double humidity;

  String get temperature {
    return Constants.convertTemperature(temperatureAsDouble);
  }

  HourlyWeatherData({
    required this.time,
    required this.dateTime,
    required this.temperatureAsDouble,
    required this.iconPath,
    required this.pressure,
    required this.windSpeed,
    required this.humidity,
  });
}
