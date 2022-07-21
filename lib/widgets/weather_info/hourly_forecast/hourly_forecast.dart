import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/weather_info/fitted_text.dart';
import 'package:weather_app/widgets/weather_info/hourly_forecast/hourly_forecast_item.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    final hourlyData =
        Provider.of<WeatherDataProvider>(context).hourlyWeatherData;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedText(
            title: 'Today',
            height: height * 0.2,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) => HourlyForecastItem(
                height: height * 0.7,
                time: hourlyData[index]['time'],
                temperature:
                    Constants.convertTemperature(hourlyData[index]['temp']),
                iconPath: hourlyData[index]['iconPath'],
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),
        ],
      ),
    );
  }
}
