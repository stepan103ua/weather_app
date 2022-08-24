import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/chart_cubit.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/enums/chart_filters.dart';

class FilterListItem extends StatelessWidget {
  const FilterListItem(
      {Key? key, required this.title, this.isLast, required this.filter})
      : super(key: key);
  final String title;
  final bool? isLast;
  final ChartFilters filter;
  @override
  Widget build(BuildContext context) {
    final chartCubit = BlocProvider.of<ChartCubit>(context, listen: false);
    return GestureDetector(
      onTap: () => chartCubit.changeFilter(filter),
      child: BlocBuilder<ChartCubit, ChartFilters>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: state != filter
                  ? Constants.containerBackgroundColor
                  : Colors.pink,
            ),
            margin: isLast != null && isLast!
                ? null
                : const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          );
        },
      ),
    );
  }
}
