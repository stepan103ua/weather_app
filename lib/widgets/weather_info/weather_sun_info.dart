import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_data.dart';

import '../../providers/weather_data_provider.dart';
import 'curve_painter.dart';

class WeatherSunInfo extends StatelessWidget {
  const WeatherSunInfo({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;

  Widget _buildSunDataItem(String assetPath, bool isSun, WeatherData data) {
    return Row(
      children: [
        if (!isSun)
          Text(
            data.sunsetTime,
            style: TextStyle(color: Colors.white),
          ),
        Image.asset(
          assetPath,
          height: height * 0.3,
          width: height * 0.3,
        ),
        if (isSun)
          Text(
            data.sunriseTime,
            style: TextStyle(color: Colors.white),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return CustomPaint(
      painter: CurveLinePainter(),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
              bottom: height * 0.3,
              left: width * 0.05,
              child:
                  _buildSunDataItem('assets/images/sun.png', true, weatherData),
            ),
            Positioned(
              top: height * 0.3,
              right: width * 0.05,
              child: _buildSunDataItem(
                  'assets/images/moon.png', false, weatherData),
            ),
          ],
        ),
      ),
    );
  }
}
