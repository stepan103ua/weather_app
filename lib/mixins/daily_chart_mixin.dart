import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/enums/chart_daily_filters.dart';

import '../models/daily_weather_data.dart';

mixin DailyChartMixin {
  var maxY = double.minPositive;
  var minY = double.maxFinite;
  var spotsList = <FlSpot>[];

  void calculate(ChartDailyFilters filters, List<DailyWeatherData> dataList) {
    calculateSpots(filters, dataList);
    calculateMaxAndMinY(filters);
  }

  void calculateSpots(
      ChartDailyFilters filters, List<DailyWeatherData> dataList) {
    spotsList = [];
    for (int i = 0; i < dataList.length; i++) {
      FlSpot spot;
      switch (filters) {
        case ChartDailyFilters.byHumidity:
          spot = FlSpot(i.toDouble(), dataList[i].humidityAsDouble);
          break;
        case ChartDailyFilters.byPressure:
          spot = FlSpot(i.toDouble(), dataList[i].pressureAsDouble);
          break;
        case ChartDailyFilters.byWindSpeed:
          spot = FlSpot(i.toDouble(), dataList[i].windSpeedAsDouble);
          break;
        case ChartDailyFilters.byMinTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].minTemperatureAsDouble);
          break;
        case ChartDailyFilters.byMaxTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].maxTemperatureAsDouble);
          break;
        case ChartDailyFilters.byDayTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].dayTemperatureAsDouble);
          break;
        case ChartDailyFilters.byNightTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].nightTemperatureAsDouble);
          break;
        case ChartDailyFilters.byMorningTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].morningTemperatureAsDouble);
          break;
        case ChartDailyFilters.byEveningTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].eveningTemperatureAsDouble);
          break;
      }
      spotsList.add(spot);
    }
  }

  void calculateMaxAndMinY(ChartDailyFilters filters) {
    var maxValue = double.minPositive;
    var minValue = double.maxFinite;
    for (final spot in spotsList) {
      if (spot.y > maxValue) {
        maxValue = spot.y;
      }
      if (spot.y < minValue) {
        minValue = spot.y;
      }
    }

    switch (filters) {
      case ChartDailyFilters.byHumidity:
        maxValue = 100;
        minValue = 0;
        break;
      case ChartDailyFilters.byPressure:
        maxValue += 20;
        minValue -= 20;
        break;
      case ChartDailyFilters.byWindSpeed:
        maxValue += 1;
        minValue = 0;
        break;
      default:
        maxValue += 5;
        minValue -= 5;
        break;
    }
    maxY = maxValue;
    minY = minValue;
  }

  FlTitlesData getTitleData(
      ChartDailyFilters filters, List<DailyWeatherData> dataList) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        axisNameSize: 30,
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                dataList[value.toInt()].day,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          },
          interval: 2,
          reservedSize: 50,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            late String text;
            switch (filters) {
              case ChartDailyFilters.byHumidity:
                text = '$value %';
                break;
              case ChartDailyFilters.byPressure:
                text = '$value mBar';
                break;
              case ChartDailyFilters.byWindSpeed:
                text = Constants.convertSpeed(value);
                break;
              default:
                text = Constants.convertTemperature(value);
                break;
            }
            return Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            );
          },
          interval: 8,
          reservedSize: 40,
        ),
      ),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) => Container(),
      )),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) => Container(),
      )),
    );
  }
}
