import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/exceptions/no_location_found.dart';
import 'package:weather_app/models/daily_weather_data.dart';
import 'package:weather_app/models/hourly_weather_data.dart';

import '../constants.dart';

mixin WeatherMixin {
  String formatDate(int utc) {
    return DateFormat('jm')
        .format(DateTime.fromMillisecondsSinceEpoch((utc) * 1000));
  }

  Future<Placemark> getAddressData(double latitude, double longitude) async {
    final addresses = await GeocodingPlatform.instance
        .placemarkFromCoordinates(
          latitude,
          longitude,
          localeIdentifier: 'en',
        )
        .timeout(
          const Duration(seconds: 30),
        );
    final address = addresses.firstWhere(
      (element) =>
          element.locality != null &&
          element.isoCountryCode != null &&
          element.isoCountryCode!.isNotEmpty &&
          element.locality!.isNotEmpty,
      orElse: () => throw NoLocationFound('Failed to find location'),
    );
    return address;
  }

  List<HourlyWeatherData> getHourlyWeatherData(List dataList) {
    return dataList.where((apiData) {
      final date = DateTime.fromMillisecondsSinceEpoch((apiData['dt']) * 1000);
      return date.isAfter(DateTime.now()) &&
          date.isBefore(DateTime.now().add(const Duration(hours: 24)));
    }).map((apiData) {
      final datetime =
          DateTime.fromMillisecondsSinceEpoch(apiData['dt'] * 1000);
      print(datetime);
      final time = formatDate(apiData['dt']);
      final pressure = double.parse(apiData['pressure'].toString());
      final humidity = double.parse(apiData['humidity'].toString());
      final windSpeed = double.parse(apiData['wind_speed'].toString());
      final temperatureAsDouble = double.parse(apiData['temp'].toString());
      final temperature = Constants.convertTemperature(temperatureAsDouble);
      final iconPath = Constants.getIconPath(apiData['weather'][0]['icon']);
      return HourlyWeatherData(
        time: time,
        temperatureAsDouble: temperatureAsDouble,
        dateTime: datetime,
        iconPath: iconPath,
        pressure: pressure,
        humidity: humidity,
        windSpeed: windSpeed,
      );
    }).toList();
  }

  List<DailyWeatherData> getDailyWeatherData(List dataList) {
    return dataList
        .map(
          (apiData) {
            final day = DateFormat('EEEE').format(
                DateTime.fromMillisecondsSinceEpoch(apiData['dt'] * 1000));
            final maxTemperature = Constants.convertTemperature(
                double.parse(apiData['temp']['max'].toString()));
            final minTemperature = Constants.convertTemperature(
                double.parse(apiData['temp']['min'].toString()));
            final iconPath =
                Constants.getIconPath(apiData['weather'][0]['icon']);
            return DailyWeatherData(
                day: day,
                maxTemperature: maxTemperature,
                minTemperature: minTemperature,
                iconPath: iconPath);
          },
        )
        .skip(1)
        .toList();
  }
}
