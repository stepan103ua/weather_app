import 'package:flutter/material.dart';
import 'package:weather_app/widgets/location_selection/selection_screen.dart';

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: LocationSelection()),
    );
  }
}
