import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double? width;
  final Function()? onPressed;
  final String? text;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final double? height;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Widget? child;
  final bool fittedBox;

  const MyButton({
    super.key,
    this.width,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.fontSize,
    this.color,
    this.height,
    this.borderColor,
    this.borderRadius,
    this.child,
    this.fittedBox = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 120,
      height: height ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(0, 3))
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        // color: const Color(0xff0082E1),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? const Color(0xff0082E1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: borderColor ?? Colors.white,
                    width: 2,
                  ))),
        ),
        child: fittedBox
            ? FittedBox(
                child: child ??
                    Text(
                      text ?? "",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: color ?? Colors.white,
                      ),
                    ),
              )
            : child ??
                Text(
                  text ?? "",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.white,
                  ),
                ),
      ),
    );
  }
}
