import 'package:flutter/material.dart';
import 'package:ftest/data/models/user_model.dart';
import 'package:ftest/data/services/auth_service.dart';
import 'package:ftest/data/services/data_service.dart';
import 'package:ftest/main.dart';
import 'package:ftest/pages/login/view/widgets/my_button.dart';
import 'package:ftest/pages/login/view/widgets/my_text_field.dart';
import 'package:ftest/pages/widgets/temp.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nicknameController = TextEditingController();

  AuthService authService = AuthService();

  Future<void> getData() async {
    var nickname = await authService.getNickName(
        authService.currentUser()!.email!, nicknameController.text);
    nicknameController.text = nickname ?? "";
    print(authService.currentUser()?.email);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff14BCF1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                AuthService authService = AuthService();
                await authService.signOut();
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/user.png"),
                const TempText(title: "30    Test"),
                const TempText(title: "15    Min"),
                const SizedBox(height: 50),
                MyTextField(
                  hintText: "Nickname",
                  controller: nicknameController,
                ),
                const SizedBox(height: 80),
                MyButton(
                  onPressed: () {
                    authService.setNickName(nicknameController.text.trim());
                    Navigator.of(context).pushNamed("/question");
                  },
                  text: "Start",
                  width: size.width * 0.6,
                  height: 74,
                  color: const Color(0xff0082E1),
                  backgroundColor: const Color(0xffF0FF45),
                  fontSize: 40,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
