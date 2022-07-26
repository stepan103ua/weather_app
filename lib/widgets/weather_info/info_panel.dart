import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/speed_type_provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../providers/weather_data_provider.dart';
import '../general/icon_with_text.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel(
      {Key? key, required this.height, required this.width, this.padding})
      : super(key: key);
  final double height;
  final double width;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithText(
            icon: WeatherIcons.humidity,
            text: '${weatherData!.currentHumidity} %',
            width: width * 0.25,
          ),
          IconWithText(
            icon: WeatherIcons.barometer,
            text: '${weatherData.currentPressure} mBar',
            width: width * 0.25,
          ),
          Consumer<SpeedTypeProvider>(
            builder: (context, value, child) => IconWithText(
              icon: WeatherIcons.windy,
              text: weatherData.currentWindSpeed,
              width: width * 0.25,
            ),
          ),
        ],
      ),
    );
  }
}
