import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_info/weather_info.dart';

class WeatherInfoScreen extends StatelessWidget {
  const WeatherInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherInfo(),
    );
  }
}
