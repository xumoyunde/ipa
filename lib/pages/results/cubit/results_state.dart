part of 'results_cubit.dart';

abstract class ResultsState extends Equatable {
  ResultsState();
}

class ResultsLoading extends ResultsState {
  @override
  List<Object?> get props => [];
}

class ResultsSuccess extends ResultsState {
  final int correctAnswersCount;
  final int incorrectAnswersCount;
  List<Results> results;
  List<QuestionModel> questions;

  ResultsSuccess(
      {required this.correctAnswersCount,
      required this.incorrectAnswersCount,
      required this.results,
      required this.questions});

  @override
  List<Object?> get props => [];
}

class ResultsEmpty extends ResultsState {
  ResultsEmpty();

  @override
  List<Object?> get props => [];
}

class ResultsFailure extends ResultsState {
  final String error;

  ResultsFailure(this.error);

  @override
  List<Object?> get props => [];
}
