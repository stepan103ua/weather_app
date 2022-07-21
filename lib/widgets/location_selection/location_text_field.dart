import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/screens/weather_info_screen.dart';

class LocationTextField extends StatelessWidget {
  LocationTextField({Key? key}) : super(key: key);
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.6,
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your city name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                final result = await Provider.of<WeatherDataProvider>(context,
                        listen: false)
                    .getUserLocationWithQuery(_textController.text);
                if (result) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const WeatherInfoScreen()));
                }
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
