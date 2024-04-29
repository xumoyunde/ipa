import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ftest/core/constants/colors.dart';
import 'package:ftest/data/services/auth_service.dart';
import 'package:ftest/pages/widgets/temp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  StreamSubscription<User?>? authChanges;
  AuthService authService = AuthService();

  Future<bool> checkUser(User user) async {
    return await authService.isUser(user);
  }

  Future<bool> checkAdmin(User user) async {
    return await _authService.isAdmin(user);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      authChanges =
          _authService.auth.authStateChanges().listen((User? user) async {
        if (user != null) {
          if (await checkUser(user)) {
            Navigator.of(context).pushReplacementNamed("/home");
            return;
          }
          if (await checkAdmin(user)) {
            Navigator.of(context).pushReplacementNamed("/admin");
            return;
          }
          Navigator.pushReplacementNamed(context, "/login");
        } else {
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    authChanges?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/icons/logo.png",
              width: size.width * 0.5,
            ),
          ),
          Positioned(
            bottom: 48,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Image.asset("assets/icons/devclub.png",
                        height: size.width * 0.14),
                    const TempText(
                      title: "DevClub",
                      color: MyColors.black,
                      fontSize: 20,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/icons/letter-z.png",
                        height: size.width * 0.14),
                    const TempText(
                      title: "Founder: Ziyoxoja",
                      color: MyColors.black,
                      fontSize: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
