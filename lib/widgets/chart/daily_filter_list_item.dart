import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/daily_chart_cubit/daily_chart_filters_cubit.dart';
import 'package:weather_app/enums/chart_daily_filters.dart';

import 'filter_list_item.dart';

class DailyFilterListItem extends StatelessWidget {
  const DailyFilterListItem(
      {Key? key, required this.title, required this.filter, this.isLast})
      : super(key: key);
  final String title;
  final ChartDailyFilters filter;
  final bool? isLast;

  void _changeFilter(BuildContext context) {
    BlocProvider.of<DailyChartFiltersCubit>(context).changeFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChartFiltersCubit, ChartDailyFilters>(
      builder: (context, state) {
        return FilterListItem(
          isSelected: state == filter,
          isLast: isLast,
          title: title,
          onTap: () => _changeFilter(context),
        );
      },
    );
  }
}
