import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/main.dart';
import 'package:ftest/pages/add_test/cubit/test_cubit.dart';
import 'package:ftest/pages/add_test/widgets/admin_text_field.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';
import 'package:ftest/pages/widgets/temp.dart';

class AddTestPage extends StatefulWidget {
  final QuestionModel? question;
  final int? index;

  const AddTestPage({super.key, this.question, this.index});

  @override
  State<AddTestPage> createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  Future<void> getId() async {
    if (widget.question != null) {
      context.read<TestCubit>().getTestById(widget.question, widget.index);
    } else {
      await context.read<TestCubit>().getQuestions();
    }
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14BCF1),
      body: BlocBuilder<TestCubit, TestState>(builder: (context, state) {
        if (state is TestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TestInitial) {
          print("initial");
          return buildScaffold(context, state);
        } else if (state is CorrectAnswerChanged) {
          return buildScaffold(context, state);
        } else if (state is TestFailure) {
          return Center(
            child: Text(state.error),
          );
        }
        print("state not");
        return const Center(
          child: Text("No State Found"),
        );
      }),
    );
  }

  Widget buildScaffold(BuildContext context, state) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 40),
                  Container(
                    alignment: Alignment.center,
                    width: 72,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFD600),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: FittedBox(
                      child: Text(
                        "${context.read<TestCubit>().index}",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const TempText(title: "Test", fontSize: 56),
                ],
              ),
              BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                return AdminTextField(
                  controller: context.read<TestCubit>().questionController,
                  hintText: "Savol",
                );
              }),
              const SizedBox(height: 20),
              BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                return AdminTextField(
                  controller: context.read<TestCubit>().optionA,
                  prefix: 'a',
                  suffix: Radio(
                    value: 1,
                    activeColor: Colors.blue,
                    groupValue: context.read<TestCubit>().oneValue,
                    onChanged: (int? value) {
                      context.read<TestCubit>().changeValue(1);
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                return AdminTextField(
                  controller: context.read<TestCubit>().optionB,
                  prefix: 'b',
                  suffix: Radio(
                    value: 2,
                    activeColor: Colors.blue,
                    groupValue: context.read<TestCubit>().oneValue,
                    onChanged: (int? value) {
                      context.read<TestCubit>().changeValue(2);
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                return AdminTextField(
                  controller: context.read<TestCubit>().optionC,
                  prefix: 'c',
                  suffix: Radio(
                    value: 3,
                    activeColor: Colors.blue,
                    groupValue: context.read<TestCubit>().oneValue,
                    onChanged: (int? value) {
                      context.read<TestCubit>().changeValue(3);
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                return AdminTextField(
                  controller: context.read<TestCubit>().optionD,
                  prefix: 'd',
                  suffix: Radio(
                    value: 4,
                    activeColor: Colors.blue,
                    groupValue: context.read<TestCubit>().oneValue,
                    onChanged: (int? value) {
                      context.read<TestCubit>().changeValue(4);
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      debugPrint("Left Arrow Pressed");
                      await context.read<TestCubit>().addQuestion();
                    },
                    child: Image.asset("assets/icons/arrow_left.png"),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      if (context.read<TestCubit>().validate() &&
                          state.value != -1 &&
                          state.value != 0) {
                        await context.read<TestCubit>().addQuestion();
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              content:
                                  Text("Ma'lumotlar muvoffaqiyatli saqlandi")));
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Savol va javoblar bo'sh bo'lishi mumkin emas"),
                            ),
                          );
                      }
                    },
                    child: Image.asset("assets/icons/done.png"),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      debugPrint("Right Arrow Pressed");
                    },
                    child: Image.asset("assets/icons/arrow_right.png"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/questions");
                },
                width: size.width * 0.6,
                height: 54,
                text: "Tugatish",
                fontSize: 32,
                backgroundColor: const Color(0xff2E9CBE),
                borderColor: const Color(0xff2FF12B),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
