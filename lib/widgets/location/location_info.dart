import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/screens/location_selection_screen.dart';

import '../../constants.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LocationSelectionScreen(),
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.location_searching_rounded,
                color: Constants.lightGrey,
              ),
              SizedBox(width: 10),
              Text(
                'Your Location Now',
                style: TextStyle(
                    fontSize: 16,
                    color: Constants.lightGrey,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text('${weatherData!.cityName}, ${weatherData.country}',
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
