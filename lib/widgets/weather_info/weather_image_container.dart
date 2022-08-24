import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';

class WeatherImageContainer extends StatelessWidget {
  const WeatherImageContainer(
      {Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    final iconPath = Provider.of<WeatherDataProvider>(context)
        .weatherData
        .currentWeatherIconPath;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Image.asset(
        iconPath,
        height: height,
        width: width * 0.9,
      ),
    );
  }
}
