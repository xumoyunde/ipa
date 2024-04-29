part of 'questions_cubit.dart';

abstract class QuestionsState extends Equatable {

}

class QuestionsInitial extends QuestionsState {
  @override
  List<Object?> get props => [];
}
class QuestionsLoading extends QuestionsState {
  @override
  List<Object?> get props => [];
}
class QuestionsSuccess extends QuestionsState {
  final List<QuestionModel> questions;
  QuestionsSuccess(this.questions);
  @override
  List<Object?> get props => [questions];
}
class QuestionsFailure extends QuestionsState {
  final String error;
  QuestionsFailure(this.error);
  @override
  List<Object?> get props => [error];
}