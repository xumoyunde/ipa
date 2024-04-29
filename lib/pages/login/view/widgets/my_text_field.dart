import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;

  const MyTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.onChanged,
      this.keyboardType, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFEFEFE),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xffD7D7D7)),
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(0, 3))
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40.0),
      // WiFi
      child: TextField(
        obscureText: obscureText!,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD7D7D7)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0082E1), width: 2),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
