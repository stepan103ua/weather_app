import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/enums/chart_daily_filters.dart';
import 'package:weather_app/widgets/chart/daily_filter_list_item.dart';
import 'package:weather_app/widgets/chart/daily_line_chart.dart';
import '../../blocs/daily_chart_cubit/daily_chart_filters_cubit.dart';
import 'filter_list.dart';

class ChartContainerDaily extends StatelessWidget {
  const ChartContainerDaily({Key? key}) : super(key: key);
  final _filterListItems = const <DailyFilterListItem>[
    DailyFilterListItem(
      title: "By Day Temperature",
      filter: ChartDailyFilters.byDayTemperature,
    ),
    DailyFilterListItem(
      title: "By Max Temperature",
      filter: ChartDailyFilters.byMaxTemperature,
    ),
    DailyFilterListItem(
      title: "By Min Temperature",
      filter: ChartDailyFilters.byMinTemperature,
    ),
    DailyFilterListItem(
      title: "By Night Temperature",
      filter: ChartDailyFilters.byNightTemperature,
    ),
    DailyFilterListItem(
      title: "By Morning Temperature",
      filter: ChartDailyFilters.byMorningTemperature,
    ),
    DailyFilterListItem(
      title: "By Evening Temperature",
      filter: ChartDailyFilters.byEveningTemperature,
    ),
    DailyFilterListItem(
      title: "By Humidity",
      filter: ChartDailyFilters.byHumidity,
    ),
    DailyFilterListItem(
      title: "By Pressure",
      filter: ChartDailyFilters.byPressure,
    ),
    DailyFilterListItem(
      title: "By Wind Speed",
      filter: ChartDailyFilters.byWindSpeed,
      isLast: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyChartFiltersCubit>(
      create: (context) => DailyChartFiltersCubit(),
      child: Column(
        children: [
          FilterList(
            filterListItems: _filterListItems,
          ),
          DailyLineChart(),
        ],
      ),
    );
  }
}
