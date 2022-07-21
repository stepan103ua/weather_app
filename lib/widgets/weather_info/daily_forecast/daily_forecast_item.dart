import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/constants.dart';

class DailyForecastItem extends StatelessWidget {
  const DailyForecastItem(
      {Key? key,
      required this.width,
      required this.dayOfWeek,
      required this.maxTemperature,
      required this.minTemperature,
      required this.iconPath})
      : super(key: key);
  final double width;
  final String dayOfWeek;
  final String maxTemperature;
  final String minTemperature;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.25,
            child: Text(
              dayOfWeek,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Image.asset(
            iconPath,
            width: width * 0.2,
            height: width * 0.2,
          ),
          SizedBox(
            width: width * 0.25,
            child: FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    maxTemperature,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    minTemperature,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16, color: Constants.iconColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
