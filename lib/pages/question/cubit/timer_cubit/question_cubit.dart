import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/pages/question/cubit/simple_cubit/question_simple_cubit.dart';

part 'question_state.dart';

class QuestionTimeCubit extends Cubit<QuestionTimeState> {
  QuestionTimeCubit() : super(QuestionTimeInitial());

  int time = 15;
  Timer? _timer;
  int minutes = 0;
  int seconds = 0;
  var sekundomer = "";
  double max = 0;
  double value = 0;

  void startTimer(BuildContext context) {
    print("timer");
    emit(QuestionTimeInitial());
    var countdown = time * 60;
    final duration = Duration(minutes: time);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      minutes = (duration.inSeconds - timer.tick) ~/ 60;
      seconds = (duration.inSeconds - timer.tick) % 60;
      print('$minutes:${seconds.toString().padLeft(2, '0')}');
      sekundomer = '$minutes:${seconds.toString().padLeft(2, '0')}';
      max = countdown.toDouble();
      emit(QuestionTimeUpdate(timer.tick.toDouble()));
      if (timer.tick >= duration.inSeconds) {
        timer.cancel();
        context.read<QuestionSimpleCubit>().timeIsUp(context);
        print('Timer completed!');
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    emit(QuestionTimeIsUp());
  }
}
