import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app_settings.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/screen_layout.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/screens/location_selection_screen.dart';
import 'package:weather_app/screens/weather_info_screen.dart';
import 'package:weather_app/widgets/general/error.dart';
import 'package:weather_app/widgets/general/loading.dart';

import 'providers/favorite_cities_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<void> loadAllData(BuildContext context) async {
    await loadAppSettings();

    await Provider.of<WeatherDataProvider>(context, listen: false)
        .loadCurrentData();
    await Provider.of<FavoriteCitiesProvider>(context, listen: false)
        .loadItems();
  }

  Future<void> loadAppSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final temperatureTypeString =
        sharedPreferences.getString('temperature_type');
    final speedTypeString = sharedPreferences.getString('speed_type');
    if (speedTypeString != null) {
      final speedType = Constants.convertToSpeedType(speedTypeString);
      if (speedType != null) {
        AppSettings.speedType = speedType;
      }
    }
    if (temperatureTypeString != null) {
      final temperatureType =
          Constants.convertToTemperatureType(temperatureTypeString);
      if (temperatureType != null) {
        AppSettings.temperatureType = temperatureType;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAllData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }
        final weatherData =
            Provider.of<WeatherDataProvider>(context, listen: false)
                .weatherData;
        if (weatherData == null) {
          return const LocationSelectionScreen();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const ScreenLayout();
        }
        return const Error();
      },
    );
  }
}
