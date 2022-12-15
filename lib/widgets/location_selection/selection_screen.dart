import 'package:flutter/material.dart';

import 'location_buttons.dart';

class LocationSelection extends StatelessWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.15,
              ),
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(height: 15),
              Text(
                'Select your location',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              const LocationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
