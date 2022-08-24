import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/enums/chart_filters.dart';

import '../models/hourly_weather_data.dart';

mixin ChartMixin {
  var maxY = double.minPositive;
  var minY = double.maxFinite;
  var spotsList = <FlSpot>[];

  void calculateHours(ChartFilters filters, List<HourlyWeatherData> dataList) {
    calculateSpots(filters, dataList);
    calculateMaxAndMinY(filters);
  }

  void calculateMaxAndMinY(ChartFilters filters) {
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
      case ChartFilters.byTemperature:
        maxValue += 5;
        minValue -= 5;
        break;
      case ChartFilters.byHumidity:
        maxValue = 100;
        minValue = 0;
        break;
      case ChartFilters.byPressure:
        maxValue += 20;
        minValue -= 20;
        break;
      case ChartFilters.byWindSpeed:
        maxValue += 1;
        minValue = 0;
        break;
    }
    maxY = maxValue;
    minY = minValue;
  }

  void calculateSpots(ChartFilters filters, List<HourlyWeatherData> dataList) {
    spotsList = <FlSpot>[];
    for (int i = 0; i < dataList.length; i++) {
      late FlSpot spot;
      switch (filters) {
        case ChartFilters.byTemperature:
          spot = FlSpot(i.toDouble(), dataList[i].temperatureAsDouble);
          break;
        case ChartFilters.byHumidity:
          spot = FlSpot(i.toDouble(), dataList[i].humidity);
          break;
        case ChartFilters.byPressure:
          spot = FlSpot(i.toDouble(), dataList[i].pressure);
          break;
        case ChartFilters.byWindSpeed:
          spot = FlSpot(i.toDouble(), dataList[i].windSpeed);
          break;
      }
      spotsList.add(spot);
    }
  }

  FlTitlesData getTitleData(
      ChartFilters filters, List<HourlyWeatherData> dataList) {
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
                dataList[value.toInt()].time,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          },
          interval: 12,
          reservedSize: 50,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            late String text;
            switch (filters) {
              case ChartFilters.byTemperature:
                text = Constants.convertTemperature(value);
                break;
              case ChartFilters.byHumidity:
                text = '$value %';
                break;
              case ChartFilters.byPressure:
                text = '$value mBar';
                break;
              case ChartFilters.byWindSpeed:
                text = Constants.convertSpeed(value);
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
