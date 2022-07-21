import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/temperature_type_provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants.dart';
import '../general/icon_with_text.dart';

class FavoriteGridItemInfo extends StatelessWidget {
  const FavoriteGridItemInfo(
      {Key? key,
      required this.width,
      required this.height,
      required this.temperature,
      required this.iconPath,
      required this.city,
      required this.country,
      required this.humidity,
      required this.windSpeed})
      : super(key: key);
  final double width, height;
  final String temperature;
  final String iconPath;
  final String city;
  final String country;
  final String humidity;
  final String windSpeed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.3,
              height: height * 0.3,
              child: FittedBox(
                child: Consumer<TempertureTypeProvider>(
                  builder: (context, value, child) => Text(
                    temperature,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 34),
                  ),
                ),
              ),
            ),
            Image.asset(
              iconPath,
              height: height * 0.3,
              width: width * 0.3,
            )
          ],
        ),
        SizedBox(
          height: height * 0.12,
          child: FittedBox(
            child: Text(
              city,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.10,
          child: FittedBox(
            child: Text(
              country,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 16),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWithText(
              icon: WeatherIcons.humidity,
              text: '$humidity %',
              width: width * 0.35,
              height: height * 0.28,
            ),
            IconWithText(
              icon: WeatherIcons.windy,
              text: windSpeed,
              width: width * 0.35,
            )
          ],
        ),
      ],
    );
  }
}
