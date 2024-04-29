import 'package:flutter/material.dart';
import 'package:ftest/data/models/questions_model.dart';
import 'package:ftest/data/models/result_model.dart';
import 'package:ftest/pages/add_test/view/add_test_page.dart';
import 'package:ftest/pages/admin/view/admin_page.dart';
import 'package:ftest/pages/login/view/login_page.dart';
import 'package:ftest/pages/results/view/results_page.dart';
import 'package:ftest/splash_screen.dart';

import '../pages/home/view/home_page.dart';
import '../pages/question/view/question_page.dart';
import '../pages/questions/view/questions_page.dart';

class OnGenerateRouter {
  Route<dynamic>? router(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return navigateTo(const SplashScreen());
      case "/login":
        return navigateTo(const LoginPage());
      case "/home":
        return navigateTo(HomePage());
      case "/admin":
        return navigateTo(const AdminPage());
      case "/questions":
        return navigateTo(const QuestionsPage());
      case "/addTest":
        if (args is List) {
          final question = args[0].cast<QuestionModel>();
          final index = args[1].cast<int>();
          return navigateTo(AddTestPage(
            question: question,
            index: index,
          ));
        }
        return navigateTo(AddTestPage());
      case "/question":
        return navigateTo(QuestionPage());
      case "/results":
        if (args is List) {
          final questions = args[0].cast<QuestionModel>();
          final results = args[1].cast<Results>();
          return navigateTo(
              ResultsPage(questions: questions, results: results));
        } else {
          // Handle invalid arguments here (e.g., navigate to an error page)
        }
        break;
      default:
        return navigateTo(const Scaffold(
          body: Center(child: Text("No Page Found")),
        ));
    }
  }

  navigateTo(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
