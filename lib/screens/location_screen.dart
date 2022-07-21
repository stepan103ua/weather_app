import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/location/settings_dropdown_list.dart';
import 'package:weather_app/widgets/location/short_weather_info.dart';
import 'package:weather_app/widgets/location/temperature_dropdown.dart';
import 'package:weather_app/widgets/location/theme_info.dart';
import 'package:weather_app/widgets/location/wind_speed_dropdown.dart';

import '../widgets/location/location_info.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: EdgeInsets.only(
            left: constraints.maxWidth * 0.05,
            right: constraints.maxWidth * 0.05,
            top: constraints.maxHeight * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LocationInfo(),
                SizedBox(
                    height: constraints.maxHeight * 0.35,
                    child: const ThemeInfo()),
                SizedBox(height: constraints.maxHeight * 0.03),
                SizedBox(
                    height: constraints.maxHeight * 0.3,
                    child: const ShortWeatherInfo()),
                Column(
                  children: const [
                    TemperatureDropdown(),
                    WindSpeedDropdown(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
