import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeatherChart extends StatelessWidget {
  const WeatherChart(
      {Key? key,
      required this.maxY,
      required this.minY,
      required this.titlesData,
      required this.spotList,
      required this.maxX,
      required this.minX})
      : super(key: key);
  final double maxY;
  final double minY;
  final double maxX;
  final double minX;
  final FlTitlesData titlesData;
  final List<FlSpot> spotList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0), color: Colors.black38),
        child: LineChart(
          LineChartData(
            maxX: maxX,
            minX: minX,
            maxY: maxY,
            minY: minY,
            titlesData: titlesData,
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                  spots: spotList,
                  isCurved: true,
                  gradient:
                      const LinearGradient(colors: [Colors.green, Colors.blue]),
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
        ),
      ),
    );
  }
}
