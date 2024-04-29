part of 'question_simple_cubit.dart';

abstract class QuestionSimpleState extends Equatable {
  const QuestionSimpleState();

  @override
  List<Object?> get props => [];
}

class QuestionInitialState extends QuestionSimpleState {
  List<QuestionModel> questions;

  QuestionInitialState(this.questions);

  @override
  List<Object?> get props => [];
}

class QuestionLoadingState extends QuestionSimpleState {
  const QuestionLoadingState();

  @override
  List<Object?> get props => [];
}

class QuestionSuccessState extends QuestionSimpleState {
  List<QuestionModel> questions;

  QuestionSuccessState(this.questions);

  @override
  List<Object?> get props => [];
}

class QuestionUpdateState extends QuestionSimpleState {
  final List<QuestionModel> questions;
  final Color backColor;

  QuestionUpdateState(this.questions, this.backColor);

  @override
  List<Object?> get props => [];
}

class QuestionEmptyState extends QuestionSimpleState {
  @override
  List<Object?> get props => [];
}

class QuestionFailureState extends QuestionSimpleState {
  final String error;

  const QuestionFailureState(this.error);

  @override
  List<Object?> get props => [];
}
