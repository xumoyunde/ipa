import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';
import 'package:ftest/pages/questions/cubit/questions_cubit.dart';
import 'package:ftest/pages/widgets/my_icon_button.dart';
import 'package:ftest/pages/widgets/temp.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (context, state) {
      if (state is QuestionsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is QuestionsFailure) {
        return Center(child: Text(state.error));
      } else if (state is QuestionsSuccess) {
        print("success");
        return Scaffold(
          backgroundColor: const Color(0xff14BCF1),
          appBar: AppBar(
            title: const TempText(title: "Test savollari"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<QuestionsCubit>().getQuestions();
                  },
                  icon: const Icon(Icons.refresh)),
            ],
          ),
          body: SafeArea(
            child: Column(children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: state.questions.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          text:
                              "${index + 1}. ${state.questions[index].question}",
                          width: size.width * 0.6,
                          backgroundColor: const Color(0xff0F8DB5),
                          fontSize: 20,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(width: 8),
                        MyIconButton(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/addTest",
                                arguments: [state.questions[index], index]);
                          },
                          icon: Image.asset("assets/icons/edit.png"),
                          backgroundColor: const Color(0xffFFD600),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
