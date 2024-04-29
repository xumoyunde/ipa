import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  final Widget icon;
  final int count;
  final Color? color;
  const MyRow({super.key, required this.icon, required this.count, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 20),
        Text("$count", style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: color,
        ),),
      ],
    );
  }
}
