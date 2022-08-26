import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/widgets/chart/chart_container_daily.dart';
import 'package:weather_app/widgets/chart/chart_container_hourly.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              TabBar(tabs: [
                Tab(
                  text: 'Next 24 Hours',
                ),
                Tab(
                  text: "Next 7 Days",
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    ChartContainerHourly(),
                    ChartContainerDaily(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
