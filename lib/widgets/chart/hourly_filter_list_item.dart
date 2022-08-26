import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/hourly_chart_cubit/hourly_chart_cubit.dart';
import 'package:weather_app/enums/chart_hourly_filters.dart';

import 'filter_list_item.dart';

class HourlyFilterListItem extends StatelessWidget {
  const HourlyFilterListItem(
      {Key? key, required this.title, this.isLast, required this.filter})
      : super(key: key);
  final String title;
  final bool? isLast;
  final ChartHourlyFilters filter;
  void changeFilter(BuildContext context) {
    BlocProvider.of<HourlyChartCubit>(context, listen: false)
        .changeFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyChartCubit, ChartHourlyFilters>(
      builder: (context, state) {
        return FilterListItem(
          isSelected: state == filter,
          isLast: isLast,
          title: title,
          onTap: () => changeFilter(context),
        );
      },
    );
  }
}
