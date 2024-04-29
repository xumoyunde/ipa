import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/models/result_model.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit() : super(ResultsLoading());
  List<QuestionModel> questions = [];
  List<Results> results = [];
  String status = '';
  var emojis = [
    "😭",
    "🙁",
    "🥳",
  ];

  void getResults(List<QuestionModel> q, List<Results> r) {
    questions = q;
    results = r;
    emit(ResultsLoading());
    try {
      int correctAnswersCount = 0;
      int incorrectAnswersCount = 0;
      if (results.isEmpty) {
        emit(ResultsEmpty());
        return;
      }
      for (int i = 0; i < results.length; i++) {
        if (results[i].selectedIndex == questions[i].correctAnswerIndex) {
          print("Correct answer: ${results[i].selectedIndex}");
          correctAnswersCount++;
        } else {
          print("Incorrect answer: ${results[i].selectedIndex}");
          incorrectAnswersCount++;
        }
      }
      var percentageCorrect = (correctAnswersCount / questions.length) * 100;
      if (percentageCorrect <= 66) {
        status = emojis[0];
      } else if (percentageCorrect <= 85) {
        status = emojis[1];
      } else {
        status = emojis[2];
      }
      emit(ResultsSuccess(
          correctAnswersCount: correctAnswersCount,
          incorrectAnswersCount: incorrectAnswersCount,
          results: results,
          questions: questions));
    } catch (e) {
      emit(ResultsFailure(e.toString()));
    }
  }

  void closeResults(List<QuestionModel> questions, List<Results> results,
      {required BuildContext context}) {
    questions.clear();
    results.clear();
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }
}
