import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/widgets/general/rounded_container.dart';

class ThemeInfo extends StatelessWidget {
  const ThemeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Image.asset(
            'assets/images/moon.png',
            width: constraints.maxHeight * 0.83,
            height: constraints.maxHeight * 0.83,
          ),
          RoundedContainer(
              title: 'Moonlight', height: constraints.maxHeight * 0.17),
        ],
      ),
    );
  }
}
