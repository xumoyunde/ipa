part of 'question_cubit.dart';

abstract class QuestionTimeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionTimeInitial extends QuestionTimeState {
  @override
  List<Object?> get props => [];
}

class QuestionTimeUpdate extends QuestionTimeState {
  final double value;

  QuestionTimeUpdate(this.value);

  @override
  List<Object?> get props => [value];
}

class QuestionTimeSuccess extends QuestionTimeState {
  final List<QuestionModel> questions;

  QuestionTimeSuccess(this.questions);

  @override
  List<Object?> get props => [questions];
}

class QuestionTimeIsUp extends QuestionTimeState {
  QuestionTimeIsUp();

  @override
  List<Object?> get props => [];
}
