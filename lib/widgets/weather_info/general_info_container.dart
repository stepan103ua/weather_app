import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/general/rounded_container.dart';
import 'package:weather_app/widgets/weather_info/fitted_text.dart';

class GeneralInfoContainer extends StatelessWidget {
  const GeneralInfoContainer(
      {Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherDataProvider>(context, listen: false)
        .currentWeatherData;
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: height * 0.1, horizontal: width * 0.1),
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedText(
            title:
                '${weatherData['location']}, ${weatherData['isoCountryCode']}',
            height: height * 0.1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: height * 0.1),
          Consumer(
            builder: (context, value, child) => FittedText(
              title: weatherData['temp_formatted'],
              height: height * 0.3,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 55),
            ),
          ),
          SizedBox(height: height * 0.1),
          RoundedContainer(
            title: weatherData['weatherStatus'],
            height: height * 0.2,
          ),
        ],
      ),
    );
  }
}
