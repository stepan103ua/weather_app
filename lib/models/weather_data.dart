import 'package:weather_app/models/daily_weather_data.dart';
import 'package:weather_app/models/hourly_weather_data.dart';

class WeatherData {
  String cityName;
  String country;
  String currentWeatherStatus;
  String currentWeatherIconPath;
  String currentTemperature;
  String currentHumidity;
  String currentWindSpeed;
  String currentPressure;
  String sunriseTime;
  String sunsetTime;
  double currentTemperatureAsDouble;
  double currentWindSpeedAsDouble;
  List<HourlyWeatherData> hourlyWeatherList;
  List<DailyWeatherData> dailyWeatherList;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.currentWeatherStatus,
    required this.currentWeatherIconPath,
    required this.currentTemperature,
    required this.currentTemperatureAsDouble,
    required this.currentHumidity,
    required this.currentWindSpeed,
    required this.currentWindSpeedAsDouble,
    required this.currentPressure,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.hourlyWeatherList,
    required this.dailyWeatherList,
  });
}
