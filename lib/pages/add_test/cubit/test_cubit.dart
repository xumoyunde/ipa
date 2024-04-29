import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/services/data_service.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial(0)) {
    // getAllData();
  }

  final dataService = DataService();
  final questionController = TextEditingController();
  final optionA = TextEditingController();
  final optionB = TextEditingController();
  final optionC = TextEditingController();
  final optionD = TextEditingController();
  List<QuestionModel> questions = <QuestionModel>[];
  QuestionModel? currentQuestion;
  int? index;

  void getTestById(QuestionModel? question, int? i) {
    index = i;
    currentQuestion = question;
    print(currentQuestion?.correctAnswerIndex);
    questionController.text = question!.question;
    optionA.text = question.options[0];
    optionB.text = question.options[1];
    optionC.text = question.options[2];
    optionD.text = question.options[3];
    oneValue = question.correctAnswerIndex;
  }

  Future<void> getQuestions() async {
    try {
      var questions = await dataService.getQuestions();
      index = questions.length;
    } catch (e) {
      print(e);
    }
  }

  addQuestion() async {
    if (currentQuestion != null) {
      var data = await dataService.searchQuestion(currentQuestion!.qid);
      if (data != null) {
        print("updated data");
        dataService.updateQuestion(
            currentQuestion!.qid,
            QuestionModel(
                qid: currentQuestion!.qid,
                question: questionController.text.trim(),
                options: [
                  optionA.text.trim(),
                  optionB.text.trim(),
                  optionC.text.trim(),
                  optionD.text.trim(),
                ],
                correctAnswerIndex: oneValue));
        print(currentQuestion?.correctAnswerIndex);
      }
    } else {
      QuestionModel question = QuestionModel(
          qid: "",
          question: questionController.text.trim(),
          options: [
            optionA.text.trim(),
            optionB.text.trim(),
            optionC.text.trim(),
            optionD.text.trim(),
          ],
          correctAnswerIndex: oneValue);
      dataService.saveQuestions(question);
    }
    questionController.clear();
    optionA.clear();
    optionB.clear();
    optionC.clear();
    optionD.clear();
  }

  int oneValue = -1;

  void changeValue(int index) {
    oneValue = index;
    print(oneValue);
    emit(CorrectAnswerChanged(index));
  }

  bool validate() {
    if (questionController.text.isNotEmpty &&
        optionA.text.isNotEmpty &&
        optionB.text.isNotEmpty &&
        optionC.text.isNotEmpty &&
        optionD.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
