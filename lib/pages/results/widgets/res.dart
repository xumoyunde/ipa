import 'package:flutter/material.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/models/result_model.dart';

import '../../../core/constants/colors.dart';
import '../../../main.dart';
import '../../question/widgets/my_container.dart';
import '../../widgets/temp.dart';

class Res extends StatelessWidget {
  final QuestionModel question;
  final Results result;
  final int index;

  const Res({super.key, required this.question, required this.result, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.background,
        elevation: 0,
        title: TempText(title: "$index. Savol", fontSize: 24),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyContainer(text: question.question),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.separated(
                itemCount: question.options.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, i) {
                  var _prefix = ["a", "b", "c", "d"];
                  print("${question.correctAnswerIndex} : ${result.selectedIndex}");
                  return MyContainer(
                    prefix: _prefix[i],
                    width: size.width * 0.8,
                    text: question.options[i],
                    backColor:
                        question.correctAnswerIndex == i
                            ? MyColors.correctAnswer
                            : MyColors.incorrectAnswer,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
