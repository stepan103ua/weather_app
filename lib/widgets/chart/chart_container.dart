import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/chart_cubit.dart';
import 'package:weather_app/widgets/chart/filter_list.dart';
import 'package:weather_app/widgets/chart/weather_chart.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartCubit>(
      create: (context) => ChartCubit(),
      child: Column(
        children: [
          const FilterList(),
          WeatherChart(),
        ],
      ),
    );
  }
}
