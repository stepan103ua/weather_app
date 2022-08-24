import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/temperature_types.dart';

import '../app_settings.dart';

class TempertureTypeProvider with ChangeNotifier {
  void changeTemperatureType(
      BuildContext context, TemperatureType newTemperatureType) {
    if (newTemperatureType == AppSettings.temperatureType) {
      return;
    }
    AppSettings.temperatureType = newTemperatureType;
    var currentLocationTemperature =
        Provider.of<WeatherDataProvider>(context, listen: false)
            .weatherData
            .currentTemperatureAsDouble;
    Provider.of<WeatherDataProvider>(context, listen: false)
            .weatherData
            .currentTemperature =
        Constants.convertTemperature(currentLocationTemperature);

    notifyListeners();
  }
}
