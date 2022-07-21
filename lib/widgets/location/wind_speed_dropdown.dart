import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app_settings.dart';
import 'package:weather_app/providers/speed_type_provider.dart';
import 'package:weather_app/speed_types.dart';
import 'package:weather_app/widgets/location/settings_dropdown_list.dart';

class WindSpeedDropdown extends StatefulWidget {
  const WindSpeedDropdown({Key? key}) : super(key: key);

  @override
  State<WindSpeedDropdown> createState() => _WindSpeedDropdownState();
}

class _WindSpeedDropdownState extends State<WindSpeedDropdown> {
  SpeedType? value = AppSettings.speedType;
  Future<void> save() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'speed_type', AppSettings.speedType.toString());
    print('saved ${AppSettings.speedType.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return SettingsDropdownList(
      value: value,
      title: 'Wind speed',
      items: [
        DropdownMenuItem<SpeedType>(
          value: SpeedType.meterPerSecond,
          child: Text(
            'Meter / Second',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        DropdownMenuItem<SpeedType>(
          value: SpeedType.kilometerPerHour,
          child: Text(
            'Kilometer / Hour',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        DropdownMenuItem<SpeedType>(
          value: SpeedType.milePerHour,
          child: Text(
            'Mile / Hour',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
      onChanged: (newValue) {
        setState(() {
          value = newValue as SpeedType;
          Provider.of<SpeedTypeProvider>(context, listen: false)
              .changeSpeedType(context, newValue);
        });
        save();
      },
    );
  }
}
