import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/hourly_chart_cubit/hourly_chart_cubit.dart';
import 'package:weather_app/widgets/chart/filter_list.dart';
import 'package:weather_app/widgets/chart/hourly_line_chart.dart';
import 'package:weather_app/widgets/chart/weather_chart.dart';

import '../../enums/chart_hourly_filters.dart';
import 'hourly_filter_list_item.dart';

class ChartContainerHourly extends StatelessWidget {
  const ChartContainerHourly({Key? key}) : super(key: key);
  final _filterListItems = const [
    HourlyFilterListItem(
      title: "By Temperature",
      filter: ChartHourlyFilters.byTemperature,
    ),
    HourlyFilterListItem(
      title: "By Humidity",
      filter: ChartHourlyFilters.byHumidity,
    ),
    HourlyFilterListItem(
      title: "By Pressure",
      filter: ChartHourlyFilters.byPressure,
    ),
    HourlyFilterListItem(
      title: "By Wind Speed",
      filter: ChartHourlyFilters.byWindSpeed,
      isLast: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HourlyChartCubit>(
      create: (context) => HourlyChartCubit(),
      child: Column(
        children: [
          FilterList(
            filterListItems: _filterListItems,
          ),
          HourlyLineChart(),
        ],
      ),
    );
  }
}
