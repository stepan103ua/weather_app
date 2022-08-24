import 'package:flutter/cupertino.dart';
import 'package:weather_app/enums/chart_filters.dart';
import 'package:weather_app/widgets/chart/filter_list_item.dart';

class FilterList extends StatelessWidget {
  const FilterList({Key? key}) : super(key: key);

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
          children: const [
            FilterListItem(
              title: "By Temperature",
              filter: ChartFilters.byTemperature,
            ),
            FilterListItem(
              title: "By Humidity",
              filter: ChartFilters.byHumidity,
            ),
            FilterListItem(
              title: "By Pressure",
              filter: ChartFilters.byPressure,
            ),
            FilterListItem(
              title: "By Wind Speed",
              filter: ChartFilters.byWindSpeed,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}
