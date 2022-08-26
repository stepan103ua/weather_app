import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/enums/chart_daily_filters.dart';

class DailyChartFiltersCubit extends Cubit<ChartDailyFilters> {
  DailyChartFiltersCubit() : super(ChartDailyFilters.byDayTemperature);

  void changeFilter(ChartDailyFilters filter) {
    if (filter != state) {
      emit(filter);
    }
  }
}
