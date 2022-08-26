import 'package:flutter/cupertino.dart';
import 'package:weather_app/enums/chart_hourly_filters.dart';
import 'package:weather_app/widgets/chart/daily_filter_list_item.dart';
import 'package:weather_app/widgets/chart/filter_list_item.dart';
import 'package:weather_app/widgets/chart/hourly_filter_list_item.dart';

class FilterList extends StatelessWidget {
  const FilterList({Key? key, required this.filterListItems}) : super(key: key);
  final List<Widget> filterListItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterListItems,
        ),
      ),
    );
  }
}
