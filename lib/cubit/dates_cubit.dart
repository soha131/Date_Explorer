import 'dart:io';
import 'package:bloc/bloc.dart';
import '../dates_model.dart';
import '../service.dart';
import 'dates_state.dart';


class DatesCubit extends Cubit<DatesState> {
  DatesCubit() : super(DatesInitial());
  dates(File file) async {
    try {
      emit(DatesLoading());
      DatePrediction? result = await ApiService().fetchDataFromApi(file);

      emit(DatesSuccess(result!));
    } catch (e) {
      emit(DatesError("Error: $e"));
    }
    return null;
  }
}
