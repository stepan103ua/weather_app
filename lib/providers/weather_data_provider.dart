import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/exceptions/weather_location_exception.dart';

import '../constants.dart';

class WeatherDataProvider with ChangeNotifier {
  final Map<String, dynamic> currentWeatherData = {};
  double? _latitude;
  double? _longitude;
  List<Map> hourlyWeatherData = [];
  List<Map> dailyWeatherData = [];

  String _formatData(int utc) {
    return DateFormat('jm')
        .format(DateTime.fromMillisecondsSinceEpoch((utc) * 1000));
  }

  Future<bool> getUserLocationWithGPS() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      final newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied ||
          newPermission == LocationPermission.deniedForever) {
        return false;
      }
    }
    try {
      final userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _latitude = userLocation.latitude;
      _longitude = userLocation.longitude;
    } catch (error) {
      print(error);
      return false;
    }
    if (_latitude == null || _longitude == null) {
      return false;
    }
    print('$_latitude $_longitude');
    saveLocation();
    return true;
  }

  Future<bool> getUserLocationWithQuery(String cityName) async {
    final Location address;

    try {
      final addresses = await GeocodingPlatform.instance
          .locationFromAddress(cityName, localeIdentifier: 'en');
      address = addresses.first;
    } catch (error) {
      print(error);
      return false;
    }
    _latitude = address.latitude;
    _longitude = address.longitude;
    print('$_latitude $_longitude');
    saveLocation();
    return true;
  }

  Future<void> saveLocation() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (_latitude == null || _longitude == null) {
        print('No location');
        return;
      }
      final result = await sharedPreferences.setString(
        'location',
        json.encode({
          'latitude': _latitude,
          'longitude': _longitude,
        }),
      );
      if (!result) {
        print('Error, not saved');
      }
      print('Saved');
    } catch (error) {
      print(error);
    }
  }

  Future<void> getLocation() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('location');
      print(jsonData == null);
      if (jsonData != null) {
        final Map<String, dynamic>? extractedData = json.decode(jsonData);
        _latitude = extractedData?['latitude'];
        _longitude = extractedData?['longitude'];
      }
    } catch (error) {
      print(error);
    }
  }

  Future<bool> loadCurrentData() async {
    final http.Response response;
    if (_latitude == null || _longitude == null) {
      await getLocation();
    }

    if (_latitude == null || _longitude == null) {
      return false;
    }
    try {
      final _api =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$_latitude&lon=$_longitude&exclude=minutely,alerts&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a';

      response = await http.get(Uri.parse(_api));

      final weatherApiData = json.decode(response.body);
      final currentApiData = weatherApiData['current'];
      final timezoneOffset = weatherApiData['timezone_offset'];
      final address = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
              weatherApiData['lat'], weatherApiData['lon'],
              localeIdentifier: 'en')
          .timeout(const Duration(seconds: 30));
      currentWeatherData['location'] = address.first.locality;
      currentWeatherData['isoCountryCode'] = address.first.isoCountryCode;
      currentWeatherData['sunrise'] = _formatData(currentApiData['sunrise']);
      currentWeatherData['sunset'] = _formatData(currentApiData['sunset']);
      currentWeatherData['temp'] =
          double.parse(currentApiData['temp'].toString());
      currentWeatherData['temp_formatted'] =
          Constants.convertTemperature(currentWeatherData['temp']);
      currentWeatherData['pressure'] = currentApiData['pressure'];
      currentWeatherData['humidity'] = currentApiData['humidity'];
      currentWeatherData['wind_speed'] =
          double.parse(currentApiData['wind_speed'].toString());
      currentWeatherData['wind_speed_formatted'] =
          Constants.convertSpeed(currentApiData['wind_speed']);
      currentWeatherData['weatherStatus'] =
          currentApiData['weather'][0]['main'];
      currentWeatherData['iconPath'] =
          Constants.getIconPath(currentApiData['weather'][0]['icon']);

      final hourlyApiData = weatherApiData['hourly'] as List;
      hourlyWeatherData = hourlyApiData.where((apiData) {
        final date =
            DateTime.fromMillisecondsSinceEpoch((apiData['dt']) * 1000);
        return date.isAfter(DateTime.now()) &&
            date.isBefore(DateTime.now().add(const Duration(hours: 24)));
      }).map((apiData) {
        final hourData = {};
        hourData['time'] = _formatData(apiData['dt']);
        hourData['temp'] = double.parse(apiData['temp'].toString());
        hourData['iconPath'] =
            Constants.getIconPath(apiData['weather'][0]['icon']);
        return hourData;
      }).toList();

      final dailyApiData = weatherApiData['daily'] as List;

      dailyWeatherData = dailyApiData
          .map((apiData) {
            final dayData = {};
            dayData['day'] = DateFormat('EEEE').format(
                DateTime.fromMillisecondsSinceEpoch(apiData['dt'] * 1000));
            dayData['maxTemp'] =
                double.parse(apiData['temp']['max'].toString());
            dayData['minTemp'] =
                double.parse(apiData['temp']['min'].toString());
            dayData['iconPath'] =
                Constants.getIconPath(apiData['weather'][0]['icon']);
            return dayData;
          })
          .skip(1)
          .toList();
    } catch (error) {
      print(error);
      return false;
    }

    if (response.statusCode >= 400 || currentWeatherData.isEmpty) {
      return false;
    }

    return true;
  }
}
