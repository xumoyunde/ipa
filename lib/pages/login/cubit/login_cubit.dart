import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/data/models/user_model.dart';
import 'package:ftest/data/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  final AuthService authService = AuthService();
  bool isAdmin = false;

  Future<UserModel?> login() async {
    emit(const LoginLoading());
    try {
      UserModel? user = await authService.signIn(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      print(user);
      if (user != null) {
        print("User: ${user.email}");
        isAdmin = authService.admin;
        print(isAdmin);
        emit(LoginSuccess(user));
        passwordController.clear();
        return user;
      } else {
        print("Not user found");
        emit(LoginError(exceptionToString('user-not-found')));
      }
    } on FirebaseAuthException catch (error) {
      debugPrint("FirebaseAuthException with cubit: ${error.code}");
      emit(LoginError(exceptionToString(error.code)));
    } on FirebaseException catch (error) {
      print("error: $error");
      emit(LoginError(exceptionToString(error.code)));
    } catch (e) {
      print("/////////ERROR ${e}");
    }
  }

  bool validate() {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  String exceptionToString(String errorMessage) {
    switch (errorMessage) {
      case 'user-not-found':
        return 'Foydalanuvchi topilmadi';
      case 'wrong-password':
        return 'Parol xato';
      case 'too-many-requests':
        return "Urinishlar soni oshib ketdi, keyinroq qayta urinib ko'ring";
      case 'network-request-failed':
        return "Internet ulanishi mavjud emas";
      case 'invalid-credential':
        return "Xisob ma'lumotlari yaroqsiz.";
      case 'unknown':
        return "Xatolik yuz berdi, internetga ulanishni tekshirib ko'ring";
      default:
        print(errorMessage);
        return "Aniqlanmagan xatolik";
    }
  }

// Future<void> signIn() async {
//   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
//   try {
//     await _authenticationRepository.logInWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );
//     print(emailController.text);
//     print(passwordController.text);
//     emit(state.copyWith(status: FormzSubmissionStatus.success));
//   } on LogInWithEmailAndPasswordFailure catch (e) {
//     emit(
//       state.copyWith(
//         errorMessage: e.message,
//         status: FormzSubmissionStatus.failure,
//       ),
//     );
//   } catch (_) {
//     emit(state.copyWith(status: FormzSubmissionStatus.failure));
//   }
// }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

// final nicknameController = TextEditingController();

  Future<void> createUser() async {
    try {} catch (e) {}
  }
}
