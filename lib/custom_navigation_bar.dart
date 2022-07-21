import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'screens/weather_info_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<Widget> _screensList = [
    const WeatherInfoScreen(),
  ];

  final List<Widget> _destinations = [
    const NavigationDestination(icon: Icon(Icons.home), label: 'Home')
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: _destinations);
  }
}
