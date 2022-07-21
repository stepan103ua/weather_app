import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/widgets/weather_info/general_info_container.dart';
import 'package:weather_app/widgets/weather_info/weather_image_container.dart';

class WeatherHeaderInfo extends StatelessWidget {
  const WeatherHeaderInfo({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GeneralInfoContainer(
          height: height,
          width: width * 0.5,
        ),
        WeatherImageContainer(
          height: height,
          width: width * 0.5,
        ),
      ],
    );
  }
}
