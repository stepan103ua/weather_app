import 'package:weather_app/constants.dart';

class FavoriteCityWeather {
  final String id;
  final double temperature;
  final String city;
  final String country;
  final String humidity;
  final double windSpeed;
  final String iconPath;

  String get temperatureFormatted {
    return Constants.convertTemperature(temperature);
  }

  String get windSpeedFormatted {
    return Constants.convertSpeed(windSpeed);
  }

  FavoriteCityWeather({
    required this.id,
    required this.temperature,
    required this.city,
    required this.country,
    required this.humidity,
    required this.windSpeed,
    required this.iconPath,
  });
}
