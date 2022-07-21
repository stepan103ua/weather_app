import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app_settings.dart';
import 'package:weather_app/providers/temperature_type_provider.dart';
import 'package:weather_app/temperature_types.dart';

import 'settings_dropdown_list.dart';

class TemperatureDropdown extends StatefulWidget {
  const TemperatureDropdown({Key? key}) : super(key: key);

  @override
  State<TemperatureDropdown> createState() => _TemperatureDropdownState();
}

class _TemperatureDropdownState extends State<TemperatureDropdown> {
  TemperatureType? value = AppSettings.temperatureType;
  Future<void> save() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'temperature_type', AppSettings.temperatureType.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SettingsDropdownList(
      value: value,
      title: 'Temperature',
      items: [
        DropdownMenuItem<TemperatureType>(
          value: TemperatureType.celcius,
          child: Text(
            'Celcius',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        DropdownMenuItem<TemperatureType>(
          value: TemperatureType.fahrenheit,
          child: Text(
            'Fahrenheit',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        DropdownMenuItem<TemperatureType>(
          value: TemperatureType.kelvin,
          child: Text(
            'Kelvin',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
      onChanged: (newValue) {
        setState(() {
          value = newValue as TemperatureType;
          Provider.of<TempertureTypeProvider>(context, listen: false)
              .changeTemperatureType(context, newValue);
        });
        save();
      },
    );
  }
}
