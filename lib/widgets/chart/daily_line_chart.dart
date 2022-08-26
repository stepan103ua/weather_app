import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/daily_chart_cubit/daily_chart_filters_cubit.dart';
import 'package:weather_app/enums/chart_daily_filters.dart';
import 'package:weather_app/mixins/daily_chart_mixin.dart';
import 'package:weather_app/providers/weather_data_provider.dart';
import 'package:weather_app/widgets/chart/weather_chart.dart';

class DailyLineChart extends StatelessWidget with DailyChartMixin {
  DailyLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyWeatherData =
        Provider.of<WeatherDataProvider>(context, listen: false)
            .weatherData
            .dailyWeatherList;

    return BlocBuilder<DailyChartFiltersCubit, ChartDailyFilters>(
      builder: (context, state) {
        calculate(state, dailyWeatherData);
        return WeatherChart(
          maxY: maxY,
          minY: minY,
          maxX: 6,
          minX: 0,
          titlesData: getTitleData(state, dailyWeatherData),
          spotList: spotsList,
        );
      },
    );
  }
}
