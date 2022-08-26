class DailyWeatherData {
  final String day;
  final String maxTemperature;
  final String minTemperature;
  final String iconPath;
  final double maxTemperatureAsDouble;
  final double minTemperatureAsDouble;
  final double dayTemperatureAsDouble;
  final double nightTemperatureAsDouble;
  final double morningTemperatureAsDouble;
  final double eveningTemperatureAsDouble;
  final double humidityAsDouble;
  final double windSpeedAsDouble;
  final double pressureAsDouble;

  DailyWeatherData({
    required this.day,
    required this.maxTemperature,
    required this.minTemperature,
    required this.iconPath,
    required this.dayTemperatureAsDouble,
    required this.eveningTemperatureAsDouble,
    required this.humidityAsDouble,
    required this.maxTemperatureAsDouble,
    required this.minTemperatureAsDouble,
    required this.morningTemperatureAsDouble,
    required this.nightTemperatureAsDouble,
    required this.pressureAsDouble,
    required this.windSpeedAsDouble,
  });
}
