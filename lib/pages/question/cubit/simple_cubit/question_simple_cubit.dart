import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/pages/question/cubit/timer_cubit/question_cubit.dart';

import '../../../../data/models/result_model.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../data/services/data_service.dart';

part 'question_simple_state.dart';

class QuestionSimpleCubit extends Cubit<QuestionSimpleState> {
  QuestionSimpleCubit() : super(QuestionLoadingState()) {
    getData();
  }

  AuthService authService = AuthService();
  DataService dataService = DataService();
  List<QuestionModel> questions = <QuestionModel>[];
  List<Results> results = <Results>[];
  int currentQuestionIndex = 0;
  bool isPressed = false;

  User? getUser() {
    return authService.currentUser();
  }

  Future<void> getData() async {
    emit(const QuestionLoadingState());
    try {
      questions = await dataService.getQuestions().then((value) {
        value.shuffle();
        for(var q in questions){
          if(q.correctAnswerIndex > 4){
            print("${q.qid} : ${q.correctAnswerIndex}");
          } else {
            print(q.correctAnswerIndex);
          }
        }
        questions = value.sublist(0, 30);
        return questions;
      });
      if (questions.isEmpty) {
        print('empty');
        emit(QuestionEmptyState());
        return;
      }
      print(questions.length);
      emit(QuestionInitialState(questions));
    } catch (error) {
      emit(QuestionFailureState(error.toString()));
    }
  }

  Future<void> start() async {
    emit(QuestionSuccessState(questions));
  }

  void checkAnswer(int selectedIndex) {
    isPressed = true;
    results.add(Results(
        uid: getUser()?.uid ?? "anonymous",
        qid: questions[currentQuestionIndex].qid,
        correctAnswerIndex: questions[currentQuestionIndex].correctAnswerIndex,
        selectedIndex: selectedIndex,

        dateTime: DateTime.now()));
    if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      print("correct");
      return;
    }
    print("incorrect");
    return;
  }

  void nextQuestion(BuildContext context) {
    if (isPressed) {
      isPressed = false;
      emit(const QuestionLoadingState());
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        emit(QuestionSuccessState(questions));
      } else {
        currentQuestionIndex = 0;
        timeIsUp(context);
        getData();
        context.read<QuestionTimeCubit>().emit(QuestionTimeInitial());
      }
    }
  }

  void timeIsUp(BuildContext context) {
    print("time out");
    context.read<QuestionTimeCubit>().cancel();
    Navigator.of(context).pushNamedAndRemoveUntil(
      "/results",
      (route) => false,
      arguments: [questions, results],
    );
  }
}
