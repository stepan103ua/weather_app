import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/screens/weather_info_screen.dart';
import 'package:weather_app/widgets/general/custom_progress_indicator.dart';
import 'package:weather_app/widgets/general/loading.dart';
import 'package:weather_app/widgets/location_selection/location_text_field.dart';

import '../../providers/weather_data_provider.dart';

class LocationButtons extends StatefulWidget {
  const LocationButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationButtons> createState() => _LocationButtonsState();
}

class _LocationButtonsState extends State<LocationButtons> {
  var _isLoading = false;
  final _textController = TextEditingController();

  void getLocationWithGPS() async {
    setState(() {
      _isLoading = true;
    });
    final result =
        await Provider.of<WeatherDataProvider>(context, listen: false)
            .getUserLocationWithGPS();
    setState(() {
      _isLoading = false;
    });
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void getLocationWithCityName() async {
    setState(() {
      _isLoading = true;
    });
    final result =
        await Provider.of<WeatherDataProvider>(context, listen: false)
            .getUserLocationWithQuery(_textController.text);
    setState(() {
      _isLoading = false;
    });
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _isLoading
          ? const Align(
              alignment: Alignment.topCenter, child: CustomProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.6,
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your city name',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onSubmitted: (text) => getLocationWithCityName(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: getLocationWithCityName,
                          child: const Text('Save'))
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: getLocationWithGPS,
                    icon: const Icon(Icons.gps_fixed),
                    label: const Text('Use GPS'),
                  ),
                ],
              ),
            ),
    );
  }
}
