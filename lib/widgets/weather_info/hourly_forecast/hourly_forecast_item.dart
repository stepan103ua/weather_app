import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/widgets/weather_info/fitted_text.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem(
      {Key? key,
      required this.height,
      required this.time,
      required this.temperature,
      required this.iconPath})
      : super(key: key);
  final double height;
  final String time;
  final String temperature;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedText(
            title: time,
            height: height * 0.2,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Image.asset(
            iconPath,
            height: height * 0.5,
            width: height * 0.5,
          ),
          FittedText(
            title: temperature,
            height: height * 0.3,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
