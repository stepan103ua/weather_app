import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:weather_app/helpers/dbhelper.dart';
import 'package:weather_app/models/favorite_city_weather.dart';
import 'package:weather_app/extensions/string_extension.dart';

import '../constants.dart';

class FavoriteCitiesProvider with ChangeNotifier {
  List<FavoriteCityWeather> _items = [];
  List<FavoriteCityWeather> get items => [..._items];

  Future<void> addItem(String cityName) async {
    final Location address;

    try {
      final cityCapitalized = cityName.capitalize;

      final addresses = await GeocodingPlatform.instance
          .locationFromAddress(cityName, localeIdentifier: 'en');
      print(cityName);
      address = addresses.first;

      final cityPlacemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(address.latitude, address.longitude,
              localeIdentifier: 'en');

      final url =
          'https://api.openweathermap.org/data/2.5/onecall?lat=${address.latitude}&lon=${address.longitude}&exclude=minutely,alerts&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a';
      final weatherSourceResponse = await get(Uri.parse(url));
      final weatherData = json.decode(weatherSourceResponse.body);
      final cityPlacemarkJson = cityPlacemark.first.toJson();
      final newFavoriteCity = FavoriteCityWeather(
        id: '${DateTime.now().toString()}${Random.secure().nextInt(9999)}',
        temperature: double.parse(weatherData['current']['temp'].toString()),
        city: (cityPlacemarkJson['locality'] as String).isNotEmpty
            ? cityPlacemarkJson['locality']
            : cityCapitalized,
        country: cityPlacemarkJson['isoCountryCode'].toString().isNotEmpty
            ? cityPlacemarkJson['isoCountryCode']
            : 'No country',
        humidity: weatherData['current']['humidity'].toString(),
        windSpeed:
            double.parse(weatherData['current']['wind_speed'].toString()),
        iconPath: Constants.getIconPath(
          weatherData['current']['weather'][0]['icon'],
        ),
      );
      final existingIndex = _items.indexWhere((element) =>
          element.country == newFavoriteCity.country &&
          element.city == newFavoriteCity.city);
      if (existingIndex != -1) {
        print("Allready exists");
        return;
      }
      _items.add(newFavoriteCity);
      await DBHelper.insertFavoriteCity(
          newFavoriteCity.id, cityName, address.latitude, address.longitude);
      notifyListeners();
      print(cityPlacemark.first.toJson());
    } catch (error) {
      print(error);
      print('ADD_ITEM ERROR');
    }
  }

  Future<void> loadItems() async {
    final dataList = await DBHelper.favoritesData;
    for (var cityData in dataList) {
      await updateItem(cityData['id'], cityData['city'], cityData['latitude'],
          cityData['longitude']);
    }
  }

  Future<void> updateItem(
      String id, String city, double latitude, double longitude) async {
    final cityPlacemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'en');
    if (cityPlacemarks.isEmpty) return;
    final cityPlaceMark = cityPlacemarks.first;
    final url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,alerts&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a';
    final response = await get(Uri.parse(url));
    final weatherData = json.decode(response.body);

    final newFavoriteCity = FavoriteCityWeather(
      id: id,
      temperature: double.parse(weatherData['current']['temp'].toString()),
      city: cityPlaceMark.locality != null && cityPlaceMark.locality!.isNotEmpty
          ? cityPlaceMark.locality!
          : city.capitalize!,
      country: cityPlaceMark.isoCountryCode != null &&
              cityPlaceMark.isoCountryCode!.isNotEmpty
          ? cityPlaceMark.isoCountryCode!
          : 'No country',
      humidity: weatherData['current']['humidity'].toString(),
      windSpeed: double.parse(weatherData['current']['wind_speed'].toString()),
      iconPath: Constants.getIconPath(
        weatherData['current']['weather'][0]['icon'],
      ),
    );
    final indexToReplace = _items.indexWhere((element) => element.id == id);
    if (indexToReplace == -1) {
      _items.add(newFavoriteCity);
      return;
    }
    _items.removeAt(indexToReplace);
    _items.insert(indexToReplace, newFavoriteCity);
  }

  Future<void> removeItem(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    if (_items.length <= index || index < 0) {
      return;
    }
    await DBHelper.delete(id);
    _items.removeAt(index);
    notifyListeners();
  }
}
