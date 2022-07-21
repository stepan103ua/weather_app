import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/constants.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({Key? key, required this.title, required this.height})
      : super(key: key);
  final String title;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: height,
      decoration: BoxDecoration(
        color: Constants.containerBackgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: FittedBox(
        child: Text(
          title,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
