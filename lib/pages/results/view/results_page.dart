import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/core/constants/colors.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/models/result_model.dart';
import 'package:ftest/main.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';
import 'package:ftest/pages/results/cubit/results_cubit.dart';
import 'package:ftest/pages/results/widgets/my_row.dart';
import 'package:flutter/material.dart';
import 'package:ftest/pages/results/widgets/res.dart';

class ResultsPage extends StatefulWidget {
  final List<QuestionModel> questions;
  final List<Results> results;

  const ResultsPage(
      {super.key, required this.questions, required this.results});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    print("${widget.questions.length} : ${widget.results.length}");
    context.read<ResultsCubit>().getResults(widget.questions, widget.results);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: size.width * 0.74,
                height: size.width * 0.64,
                decoration: BoxDecoration(
                  color: MyColors.whiteForShadow,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: MyColors.white, blurRadius: 3, spreadRadius: 3),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      context.read<ResultsCubit>().status,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<ResultsCubit, ResultsState>(
                        builder: (context, state) {
                      if (state is ResultsSuccess) {
                        return MyRow(
                          icon: Image.asset("assets/icons/done.png"),
                          count: (state).correctAnswersCount,
                          color: MyColors.green,
                        );
                      }
                      return MyRow(
                        icon: Image.asset("assets/icons/done.png"),
                        count: 0,
                        color: MyColors.green,
                      );
                    }),
                    BlocBuilder<ResultsCubit, ResultsState>(
                        builder: (context, state) {
                      if (state is ResultsSuccess) {
                        return MyRow(
                          icon: Image.asset("assets/icons/cross.png"),
                          count: (state).incorrectAnswersCount,
                          color: MyColors.incorrectAnswer,
                        );
                      }
                      return MyRow(
                        icon: Image.asset("assets/icons/cross.png"),
                        count: 0,
                        color: MyColors.incorrectAnswer,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.read<ResultsCubit>().closeResults(
                      context: context, widget.questions, widget.results);
                },
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyColors.white),
                    color: MyColors.whiteForShadow,
                  ),
                  child: Image.asset("assets/icons/reload.png"),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<ResultsCubit, ResultsState>(
                  builder: (context, state) {
                if (state is ResultsLoading) {
                  print("loading");
                  return const Center(
                    child: Text("Yuklanmoqda..."),
                  );
                } else if (state is ResultsEmpty) {
                  print("empty");
                  return Center(
                    child: Text("Sizda hech qanday natija mavjud emas!"),
                  );
                } else if (state is ResultsFailure) {
                  print("failure");
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is ResultsSuccess) {
                  print("success");
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.results.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      itemBuilder: (context, index) {
                        return MyButton(
                          onPressed: () {
                            print(state.questions[index].question);
                            print("state.questions[index].question/////");
                            print(state.results.length);
                            print(state.results[index].correctAnswerIndex);
                            print("state.questions[index].question/////");
                            print(state.results[index].selectedIndex);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Res(
                                  question: state.questions[index],
                                  result: state.results[index],
                                  index: index + 1,
                                ),
                              ),
                            );
                          },
                          text: "${index + 1}. savol",
                          width: size.width * 0.8,
                          backgroundColor:
                              state.questions[index].correctAnswerIndex ==
                                      state.results[index].selectedIndex
                                  ? MyColors.correctAnswer
                                  : MyColors.incorrectAnswer,
                          fontSize: 20,
                          borderRadius: BorderRadius.circular(10),
                        );
                      },
                    ),
                  );
                }
                return Column(
                  children: [
                    const Center(
                      child: Text("State not found"),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<ResultsCubit>()
                              .getResults(widget.questions, widget.results);
                        },
                        icon: Icon(Icons.refresh_outlined))
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
