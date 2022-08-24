import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/temperature_type_provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/weather_info/info_panel.dart';

class ShortWeatherInfo extends StatelessWidget {
  const ShortWeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.5,
            child: FittedBox(
              child: Consumer<TempertureTypeProvider>(
                builder: (context, value, child) => Text(
                  weatherData.currentTemperature,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          InfoPanel(
              height: constraints.maxHeight * 0.5,
              width: constraints.maxWidth * 0.9),
        ],
      ),
    );
  }
}
