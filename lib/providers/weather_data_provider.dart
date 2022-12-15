import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/mixins/weather_mixin.dart';
import 'package:weather_app/models/weather_data.dart';

import '../constants.dart';

class WeatherDataProvider with ChangeNotifier, WeatherMixin {
  double? _latitude;
  double? _longitude;

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

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
      return false;
    }
    if (_latitude == null || _longitude == null) {
      return false;
    }
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
      return false;
    }
    _latitude = address.latitude;
    _longitude = address.longitude;
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
    } catch (error) {}
  }

  Future<void> getLocation() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('location');
      if (jsonData != null) {
        final Map<String, dynamic>? extractedData = json.decode(jsonData);
        _latitude = extractedData?['latitude'];
        _longitude = extractedData?['longitude'];
      }
    } catch (_) {}
  }

  Future<bool> loadCurrentData() async {
    final http.Response response;
    print('Latitude: $_latitude, Longitude: $_longitude');
    if (_latitude == null || _longitude == null) {
      await getLocation();
    }
    print('Latitude: $_latitude, Longitude: $_longitude');

    if (_latitude == null || _longitude == null) {
      return false;
    }

    final api =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$_latitude&lon=$_longitude&exclude=minutely,alerts&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a';

    response = await http.get(Uri.parse(api));

    final weatherApiData = json.decode(response.body);
    final currentApiData = weatherApiData['current'];
    final address = await getAddressData(_latitude!, _longitude!);
    final location = address.locality;
    final countryCode = address.isoCountryCode;
    print(response.body);
    final sunriseTime = formatDate(currentApiData['sunrise']);
    final sunsetTime = formatDate(currentApiData['sunset']);
    final temperatureAsDouble = double.parse(currentApiData['temp'].toString());
    final currentTemperature =
        Constants.convertTemperature(temperatureAsDouble);
    final currentPressure = currentApiData['pressure'].toString();
    final currentHumidity = currentApiData['humidity'].toString();
    final windSpeedASDouble =
        double.parse(currentApiData['wind_speed'].toString());
    final currentWindSpeed =
        Constants.convertSpeed(currentApiData['wind_speed']);
    final currentWeatherStatus = currentApiData['weather'][0]['main'];
    final currentWeathericonPath =
        Constants.getIconPath(currentApiData['weather'][0]['icon']);

    final hourlyApiData = weatherApiData['hourly'] as List;
    final hourlyWeatherData = getHourlyWeatherData(hourlyApiData);

    final dailyApiData = weatherApiData['daily'] as List;

    final dailyWeather = getDailyWeatherData(dailyApiData);
    _weatherData = WeatherData(
      cityName: location!,
      country: countryCode!,
      currentWeatherStatus: currentWeatherStatus,
      currentWeatherIconPath: currentWeathericonPath,
      currentTemperature: currentTemperature,
      currentTemperatureAsDouble: temperatureAsDouble,
      currentHumidity: currentHumidity,
      currentWindSpeed: currentWindSpeed,
      currentWindSpeedAsDouble: windSpeedASDouble,
      currentPressure: currentPressure,
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      hourlyWeatherList: hourlyWeatherData,
      dailyWeatherList: dailyWeather,
    );

    return true;
  }
}
