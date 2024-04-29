import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/services/data_service.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(QuestionsInitial()) {
    getQuestions();
  }

  DataService dataService = DataService();

  Future<void> getQuestions() async {
    emit(QuestionsLoading());
    try {
      var result = await dataService.getQuestions();
      emit(QuestionsSuccess(result));
    } catch (e) {
      print(e);
    }
  }
}
