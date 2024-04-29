import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/core/constants/colors.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorInitialState());

  void changeColor(bool isCorrect){
    if(isCorrect){
      emit(ColorChangeState(MyColors.correctAnswer));
      return;
    }
    emit(ColorChangeState(MyColors.incorrectAnswer));
    return;
  }

  void defaultColor(){
    emit(ColorInitialState());
  }

}
