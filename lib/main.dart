import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/pages/add_test/cubit/test_cubit.dart';
import 'package:ftest/pages/question/cubit/color_cubit/color_cubit.dart';
import 'package:ftest/pages/question/cubit/simple_cubit/question_simple_cubit.dart';
import 'package:ftest/pages/questions/cubit/questions_cubit.dart';
import 'package:ftest/pages/results/cubit/results_cubit.dart';

import 'firebase_options.dart';
import 'pages/login/cubit/login_cubit.dart';
import 'pages/question/cubit/timer_cubit/question_cubit.dart';
import 'route/router.dart';

late Size size;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<TestCubit>(create: (context) => TestCubit()),
    BlocProvider<QuestionsCubit>(create: (context) => QuestionsCubit()),
    BlocProvider<QuestionTimeCubit>(create: (context) => QuestionTimeCubit()),
    BlocProvider<ResultsCubit>(create: (context) => ResultsCubit()),
    BlocProvider<QuestionSimpleCubit>(
        create: (context) => QuestionSimpleCubit()),
    BlocProvider<ColorCubit>(create: (context) => ColorCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: OnGenerateRouter().router,
    );
  }
}
