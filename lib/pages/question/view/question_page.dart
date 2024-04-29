import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/core/constants/colors.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';
import 'package:ftest/pages/question/cubit/color_cubit/color_cubit.dart';
import 'package:ftest/pages/question/cubit/simple_cubit/question_simple_cubit.dart';
import 'package:ftest/pages/question/cubit/timer_cubit/question_cubit.dart';
import 'package:ftest/pages/widgets/temp.dart';

import '../../../main.dart';
import '../widgets/my_container.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("question page");
    return Scaffold(
      backgroundColor: MyColors.background,
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                  'Chiqishni xohlayotganingizga ishonchingiz komilmi?'),
              content: const Text(
                  "Agar siz testdan voz kechsangiz, barcha yutuqlaringiz yo'qoladi."),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Bekor qilish'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                ElevatedButton(
                  child: const Text('Baribir chiqib ketish'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );

          return shouldPop ?? false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xff14BCF1),
            body: Center(
              child: SingleChildScrollView(
                child: BlocBuilder<QuestionSimpleCubit, QuestionSimpleState>(
                    builder: (context, state) {
                  if (state is QuestionEmptyState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TempText(
                          title: "Hozirda hech qanday savollar mavjud emas",
                          fontSize: 24,
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          onPressed: () async {
                            await context.read<QuestionSimpleCubit>().getData();
                          },
                          icon: const Icon(Icons.refresh, color: Colors.white),
                        ),
                      ],
                    );
                  } else if (state is QuestionLoadingState) {
                    print("loading state");
                    // context.read<QuestionSimpleCubit>().getData();
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is QuestionInitialState) {
                    print('initial state');
                    return Column(
                      children: [
                        buildQuestionBuilder(),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      buildTimeBuilder(),
                      buildQuestionBuilder(),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<QuestionSimpleCubit, QuestionSimpleState> buildQuestionBuilder() {
    return BlocBuilder<QuestionSimpleCubit, QuestionSimpleState>(
      builder: (context, state) {
        if (state is QuestionSuccessState) {
          var questions = state.questions;
          print("q: ${questions.length}");
          int index = context.read<QuestionSimpleCubit>().currentQuestionIndex;
          return Column(
            children: [
              TempText(
                title: "${index + 1} Savol",
                fontSize: 24,
              ),
              MyContainer(
                text: state.questions[index].question,
                padding: const EdgeInsets.all(20),
              ),
              const SizedBox(height: 10),
              BlocBuilder<ColorCubit, ColorState>(builder: (context, state) {
                if (state is ColorInitialState) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView.separated(
                      itemCount: questions[index].options.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, i) {
                        var _prefix = ["a", "b", "c", "d"];
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<QuestionSimpleCubit>()
                                .checkAnswer(i + 1);
                            context.read<ColorCubit>().changeColor(
                                questions[index].correctAnswerIndex == i + 1);
                          },
                          child: MyContainer(
                            prefix: _prefix[i],
                            width: size.width * 0.8,
                            text: questions[index].options[i],
                            backColor: MyColors.background,
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.separated(
                    itemCount: questions[index].options.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, i) {
                      var _prefix = ["a", "b", "c", "d"];
                      return MyContainer(
                        prefix: _prefix[i],
                        width: size.width * 0.8,
                        text: questions[index].options[i],
                        backColor: questions[index].correctAnswerIndex == i + 1
                            ? MyColors.correctAnswer
                            : MyColors.incorrectAnswer,
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  MyButton(
                    onPressed: () {
                      context.read<ColorCubit>().defaultColor();
                      context.read<QuestionSimpleCubit>().nextQuestion(context);
                    },
                    child:
                        Image.asset("assets/icons/arrow_right.png", width: 24),
                  ),
                ],
              )
            ],
          );
        }
        return Column(
          children: [
            const TempText(
              title: "Tayyromisiz?",
              fontSize: 24,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.read<QuestionSimpleCubit>().start();
              },
              child: const MyContainer(
                text: "Boshladik",
                padding: EdgeInsets.all(20),
              ),
            ),
          ],
        );
      },
    );
  }

  BlocBuilder<QuestionTimeCubit, QuestionTimeState> buildTimeBuilder() {
    return BlocBuilder<QuestionTimeCubit, QuestionTimeState>(
      builder: (context, state) {
        if (state is QuestionTimeInitial) {
          context.read<QuestionTimeCubit>().startTimer(context);
        } else if (state is QuestionTimeUpdate) {
          return Column(
            children: [
              TempText(
                fontSize: 24,
                title: context.read<QuestionTimeCubit>().sekundomer,
              ),
              SliderTheme(
                data: const SliderThemeData(
                  trackHeight: 20,
                  trackShape: RectangularSliderTrackShape(),
                ),
                child: Slider(
                  value: state.value,
                  min: 0,
                  max: context.read<QuestionTimeCubit>().max,
                  activeColor: MyColors.incorrectAnswer,
                  inactiveColor: MyColors.green,
                  thumbColor: MyColors.thumbCircle,
                  onChanged: (val) {},
                ),
              ),
            ],
          );
        } else if (state is QuestionTimeIsUp) {
          return const Column(
            children: [
              TempText(
                fontSize: 24,
                title: "Vaqt tugadi",
              ),
            ],
          );
        }
        return Column(
          children: [
            const TempText(
              fontSize: 24,
              title: "00:00",
            ),
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 20,
                trackShape: RectangularSliderTrackShape(),
              ),
              child: Slider(
                value: 0,
                min: 0,
                max: context.read<QuestionTimeCubit>().max,
                activeColor: MyColors.incorrectAnswer,
                inactiveColor: MyColors.green,
                thumbColor: MyColors.thumbCircle,
                onChanged: (val) {},
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showExitPopup(context) async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ilovadan chiqmoqchimisiz!"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text("Ha",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                        child: const Text("Yo'q",
                            style: TextStyle(color: Colors.white)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
