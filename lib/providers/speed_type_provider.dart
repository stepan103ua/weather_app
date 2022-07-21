import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/speed_types.dart';

import '../app_settings.dart';

class SpeedTypeProvider with ChangeNotifier {
  void changeSpeedType(BuildContext context, SpeedType newSpeedType) {
    if (newSpeedType == AppSettings.speedType) {
      return;
    }
    AppSettings.speedType = newSpeedType;
    final windSpeed = double.parse(
        Provider.of<WeatherDataProvider>(context, listen: false)
            .currentWeatherData['wind_speed']
            .toString());
    Provider.of<WeatherDataProvider>(context, listen: false)
            .currentWeatherData['wind_speed_formatted'] =
        Constants.convertSpeed(windSpeed);
    notifyListeners();
  }
}
