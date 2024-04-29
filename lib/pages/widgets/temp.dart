import 'package:flutter/material.dart';
import 'package:ftest/core/constants/colors.dart';

class TempText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  const TempText({super.key, required this.title, this.fontSize, this.textAlign, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      softWrap: true,
      style: TextStyle(
        fontSize: fontSize ?? 40,
        fontWeight: FontWeight.bold,
        color: color ?? MyColors.white,
      ),
    );
  }
}
