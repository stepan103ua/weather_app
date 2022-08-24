import 'package:bloc/bloc.dart' show Cubit;
import 'package:weather_app/enums/chart_filters.dart';

class ChartCubit extends Cubit<ChartFilters> {
  ChartCubit() : super(ChartFilters.byTemperature);

  void changeFilter(ChartFilters filter) {
    if (filter != state) {
      emit(filter);
    }
  }
}
