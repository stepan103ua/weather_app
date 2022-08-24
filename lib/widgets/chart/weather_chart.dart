import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/chart_cubit.dart';
import 'package:weather_app/enums/chart_filters.dart';
import 'package:weather_app/mixins/chart_mixin.dart';
import 'package:weather_app/providers/weather_data_provider.dart';

class WeatherChart extends StatelessWidget with ChartMixin {
  WeatherChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherDataProvider>(context, listen: false).weatherData;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0), color: Colors.black38),
        child: BlocBuilder<ChartCubit, ChartFilters>(
          builder: (context, state) {
            calculateHours(state, weatherData.hourlyWeatherList);
            return LineChart(
              LineChartData(
                maxX: 23,
                minX: 0,
                maxY: maxY,
                minY: minY,
                titlesData: getTitleData(state, weatherData.hourlyWeatherList),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: spotsList,
                      isCurved: true,
                      gradient: const LinearGradient(
                          colors: [Colors.green, Colors.blue]),
                      barWidth: 6,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(colors: [
                          Colors.green.withOpacity(0.3),
                          Colors.blue.withOpacity(0.3)
                        ]),
                      ))
                ],
                gridData: FlGridData(getDrawingHorizontalLine: (value) {
                  return FlLine(
                      color: Colors.green.withOpacity(0.0), strokeWidth: 1);
                }, getDrawingVerticalLine: (value) {
                  return FlLine(
                      color: Colors.green.withOpacity(0.0), strokeWidth: 1);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
