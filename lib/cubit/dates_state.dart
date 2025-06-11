
import '../dates_model.dart';

abstract class DatesState {}

class DatesInitial extends DatesState {}

class DatesLoading extends DatesState {}

class DatesSuccess extends DatesState {
  final DatePrediction prediction;
  DatesSuccess(this.prediction);
}

class DatesError extends DatesState {
  final String message;
  DatesError(this.message);
}
