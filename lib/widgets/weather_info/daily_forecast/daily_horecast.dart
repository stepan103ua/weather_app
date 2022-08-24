import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/weather_info/daily_forecast/daily_forecast_item.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    final dailyData =
        Provider.of<WeatherDataProvider>(context).weatherData.dailyWeatherList;
    return Column(
      children: dailyData.map((data) {
        return DailyForecastItem(
          width: width,
          dayOfWeek: data.day,
          maxTemperature: data.maxTemperature,
          minTemperature: data.minTemperature,
          iconPath: data.iconPath,
        );
      }).toList(),
    );
  }
}
