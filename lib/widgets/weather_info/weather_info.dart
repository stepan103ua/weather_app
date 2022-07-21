import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/exceptions/weather_location_exception.dart';
import 'package:weather_app/screens/location_selection_screen.dart';
import 'package:weather_app/widgets/general/error.dart';
import 'package:weather_app/widgets/weather_info/daily_forecast/daily_horecast.dart';
import 'package:weather_app/widgets/weather_info/hourly_forecast/hourly_forecast.dart';
import 'package:weather_app/widgets/weather_info/info_panel.dart';
import 'package:weather_app/widgets/weather_info/weather_header_info.dart';
import 'package:weather_app/widgets/weather_info/weather_sun_info.dart';

import '../../providers/weather_data_provider.dart';
import '../general/loading.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          WeatherHeaderInfo(
            height: constraints.maxHeight * 0.3,
            width: constraints.maxWidth,
          ),
          InfoPanel(
            height: constraints.maxHeight * 0.1,
            width: constraints.maxWidth,
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          ),
          WeatherSunInfo(
            height: constraints.maxHeight * 0.15,
            width: constraints.maxWidth,
          ),
          HourlyForecast(
            height: constraints.maxHeight * 0.15,
            width: constraints.maxWidth,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.02,
          ),
          DailyForecast(width: constraints.maxWidth),
        ],
      ),
    );
  }
}
