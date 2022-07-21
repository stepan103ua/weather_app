import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/general/error.dart';
import 'package:weather_app/widgets/general/loading.dart';
import 'package:weather_app/widgets/weather_info/weather_info.dart';

import 'location_selection_screen.dart';

class WeatherInfoScreen extends StatelessWidget {
  const WeatherInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherInfo(),
    );
  }
}
