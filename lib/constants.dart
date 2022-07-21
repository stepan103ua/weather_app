import 'package:flutter/material.dart';
import 'package:weather_app/app_settings.dart';
import 'package:weather_app/temperature_types.dart';

import 'speed_types.dart';

class Constants {
  static const Color scaffoldBackgroundColor = Color.fromARGB(255, 8, 27, 37);
  static const Color containerBackgroundColor = Color.fromRGBO(53, 51, 97, 1);
  static const Color iconColor = Color.fromRGBO(96, 127, 172, 1);
  static const Color gridContainerColor = Color.fromRGBO(21, 44, 57, 1);
  static const Color lightGrey = Color.fromRGBO(43, 77, 100, 1);

  static String convertTemperature(double temperature) {
    switch (AppSettings.temperatureType) {
      case TemperatureType.celcius:
        return '${temperature.toStringAsFixed(0)} °C';
      case TemperatureType.kelvin:
        return '${(temperature + 273.15).toStringAsFixed(0)} K';
      case TemperatureType.fahrenheit:
        return '${(temperature * (9 / 5) + 32).toStringAsFixed(0)} °F';
    }
  }

  static String convertSpeed(double speed) {
    switch (AppSettings.speedType) {
      case SpeedType.meterPerSecond:
        return '${speed.toStringAsFixed(1)} m/s';
      case SpeedType.kilometerPerHour:
        return '${(speed * 3.6).toStringAsFixed(1)} km/h';
      case SpeedType.milePerHour:
        return '${(speed * 2.236936).toStringAsFixed(1)} ml/h';
    }
  }

  static TemperatureType? convertToTemperatureType(String text) {
    switch (text) {
      case 'TemperatureType.celcius':
        return TemperatureType.celcius;
      case 'TemperatureType.kelvin':
        return TemperatureType.kelvin;
      case 'TemperatureType.fahrenheit':
        return TemperatureType.fahrenheit;
    }
    return null;
  }

  static SpeedType? convertToSpeedType(String text) {
    switch (text) {
      case 'SpeedType.meterPerSecond':
        return SpeedType.meterPerSecond;
      case 'SpeedType.kilometerPerHour':
        return SpeedType.kilometerPerHour;
      case 'SpeedType.milePerHour':
        return SpeedType.milePerHour;
    }
    return null;
  }

  static String getIconPath(String iconCode) {
    switch (iconCode) {
      case "01d":
        return "assets/images/sun.png";
      case "02d":
        return "assets/images/sun-cloud.png";
      case "03d":
        return "assets/images/cloud.png";
      case "04d":
        return "assets/images/cloud.png";
      case "09d":
        return "assets/images/rain.png";
      case "10d":
        return "assets/images/rain-low.png";
      case "11d":
        return "assets/images/cloud-rain-lightning.png";
      case "01n":
        return "assets/images/moon.png";
      case "02n":
        return "assets/images/moon-cloud.png";
      case "03n":
        return "assets/images/cloud.png";
      case "04n":
        return "assets/images/cloud.png";
      case "09n":
        return "assets/images/rain.png";
      case "10n":
        return "assets/images/rain-low.png";
      case "11n":
        return "assets/images/cloud-rain-lightning.png";
      default:
        return "http://openweathermap.org/img/wn/$iconCode@2x.png";
    }
  }
}
