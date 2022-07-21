import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app_settings.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/custom_navigation_bar.dart';
import 'package:weather_app/screens/favorites_screen.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/temperature_types.dart';

import 'screens/weather_info_screen.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  var _screenIndex = 0;
  final List<Widget> _screensList = [
    const WeatherInfoScreen(),
    const FavoritesScreen(),
    const LocationScreen(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  final List<Widget> _destinations = [
    const NavigationDestination(
        icon: Icon(
          Icons.home_outlined,
        ),
        selectedIcon: Icon(
          Icons.home_outlined,
          color: Colors.pink,
        ),
        label: 'Home'),
    const NavigationDestination(
        icon: Icon(
          Icons.search
        ),
        selectedIcon: Icon(
          Icons.search,
          color: Colors.pink,
        ),
        label: 'Favorite'),
    const NavigationDestination(
        icon: Icon(Icons.location_searching_outlined),
        selectedIcon: Icon(
          Icons.location_searching_outlined,
          color: Colors.pink,
        ),
        label: 'Location'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screensList[_screenIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _screenIndex,
        onDestinationSelected: (newIndex) => setState(() {
          _screenIndex = newIndex;
        }),
        destinations: _destinations,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Constants.scaffoldBackgroundColor,
      ),
    );
  }
}
