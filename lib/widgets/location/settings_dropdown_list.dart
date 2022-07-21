import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/constants.dart';

class SettingsDropdownList extends StatelessWidget {
  const SettingsDropdownList(
      {Key? key,
      required this.title,
      required this.items,
      required this.onChanged,
      this.value})
      : super(key: key);
  final String title;
  final List<DropdownMenuItem<Object>> items;
  final Function(Object?) onChanged;
  final Object? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        DropdownButton<Object>(
          value: value,
          alignment: Alignment.centerRight,
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          items: items,
          dropdownColor: Constants.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24.0),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
