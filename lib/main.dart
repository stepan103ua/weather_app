import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/providers/favorite_cities_provider.dart';
import 'package:weather_app/providers/speed_type_provider.dart';
import 'package:weather_app/providers/temperature_type_provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherDataProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteCitiesProvider()),
        ChangeNotifierProvider(create: (context) => TempertureTypeProvider()),
        ChangeNotifierProvider(create: (context) => SpeedTypeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Lato',
            scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
            appBarTheme:
                const AppBarTheme(color: Colors.transparent, elevation: 0),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
              titleMedium: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              titleSmall: TextStyle(
                color: Constants.lightGrey,
                fontSize: 20,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.black,
              iconColor: Constants.iconColor,
              hintStyle: const TextStyle(color: Constants.lightGrey),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide:
                    const BorderSide(color: Constants.iconColor, width: 3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  width: 10,
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all(
                    Constants.containerBackgroundColor),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: Colors.transparent,
              iconTheme: MaterialStateProperty.all(
                  const IconThemeData(color: Constants.iconColor)),
              labelTextStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
            )),
        home: const Home(),
      ),
    );
  }
}
