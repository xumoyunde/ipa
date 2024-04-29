import 'package:flutter/material.dart';
import 'package:ftest/data/services/auth_service.dart';
import 'package:ftest/main.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14BCF1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const SizedBox(width: 20),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final authService = AuthService();
                await authService.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
              }
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset("assets/icons/admin.png"),
                MyButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addTest");
                  },
                  text: "Test yaratish",
                  backgroundColor: const Color(0xff0F8DB5),
                  borderColor: Colors.yellow,
                  width: size.width * 0.6,
                  fontSize: 24,
                ),
                const SizedBox(height: 40),
                MyButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/questions");
                  },
                  fittedBox: true,
                  text: "Testni o'zgartirish",
                  backgroundColor: const Color(0xff0F8DB5),
                  borderColor: Colors.yellow,
                  width: size.width * 0.6,
                  fontSize: 24,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
