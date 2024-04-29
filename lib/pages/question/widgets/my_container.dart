import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String text;
  final double? width;
  final String? prefix;
  final EdgeInsets? padding;
  final Color? backColor;
  const MyContainer(
      {super.key, required this.text, this.width, this.prefix, this.padding, this.backColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width * 0.88,
      padding: padding ?? EdgeInsets.only(left: 8, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(15),
        color: backColor,
      ),
      child: Row(
        children: [
          if (prefix != null)
            Text(
              prefix!,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
