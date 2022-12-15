import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/hourly_chart_cubit/hourly_chart_cubit.dart';
import 'package:weather_app/enums/chart_hourly_filters.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/chart/weather_chart.dart';

import '../../mixins/hourly_chart_mixin.dart';

class HourlyLineChart extends StatelessWidget with HourlyChartMixin {
  HourlyLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return BlocBuilder<HourlyChartCubit, ChartHourlyFilters>(
      builder: (context, state) {
        calculateHours(state, weatherData!.hourlyWeatherList);
        return WeatherChart(
          maxY: maxY,
          minY: minY,
          maxX: 23,
          minX: 0,
          titlesData: getTitleData(state, weatherData.hourlyWeatherList),
          spotList: spotsList,
        );
      },
    );
  }
}
