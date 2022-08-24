import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/widgets/chart/chart_container.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const TabBar(tabs: [
                Tab(
                  text: 'Today',
                ),
                Tab(
                  text: "Next 7 days",
                ),
              ]),
              Expanded(
                  child: TabBarView(children: [ChartContainer(), Text('2')])),
            ],
          ),
        ),
      ),
    );
  }
}
