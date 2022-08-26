import 'package:bloc/bloc.dart' show Cubit;
import 'package:weather_app/enums/chart_hourly_filters.dart';

class HourlyChartCubit extends Cubit<ChartHourlyFilters> {
  HourlyChartCubit() : super(ChartHourlyFilters.byTemperature);

  void changeFilter(ChartHourlyFilters filter) {
    if (filter != state) {
      emit(filter);
    }
  }
}
