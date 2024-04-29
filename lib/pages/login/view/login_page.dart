import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftest/main.dart';
import 'package:ftest/pages/login/cubit/login_cubit.dart';

import 'widgets/my_button.dart';
import 'widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: const Color(0xff14BCF1),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            showMessage(context, state.error);
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildLoginForm(ctx, state);
          },
        ),
      ),
    );
  }

  Scaffold _buildLoginForm(BuildContext context, LoginState state) {
    return Scaffold(
      backgroundColor: const Color(0xff14BCF1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/user-login.png"),
          const SizedBox(height: 40),
          MyTextField(
            hintText: "Username",
            controller: context.read<LoginCubit>().usernameController,
          ),
          const SizedBox(height: 20),
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: context.read<LoginCubit>().passwordController,
          ),
          const SizedBox(height: 40),
          MyButton(
            width: size.width * 0.4,
            onPressed: () async {
              try {
                if (context.read<LoginCubit>().validate()) {
                  var user = await context.read<LoginCubit>().login();
                  if (user != null) {
                    context.read<LoginCubit>().isAdmin
                        ? Navigator.of(context).pushReplacementNamed("/admin")
                        : Navigator.of(context).pushReplacementNamed("/home");
                    return;
                  }
                  showMessage(context, "Username yoki parol xato");
                }
                showMessage(
                    context, "Username va parol bo'sh bo'lishi mumkin emas");
              } on FirebaseAuthException catch (error) {
                showMessage(context, error.toString());
              }
            },
            child: const FittedBox(
              child: Text(
                "Kirish",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showMessage(BuildContext context, String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        // duration: Duration(seconds: 4),
      ),
    );
  }
}
