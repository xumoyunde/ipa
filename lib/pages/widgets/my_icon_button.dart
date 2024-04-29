import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? icon;
  final Color? backgroundColor;
  const MyIconButton({super.key, this.onTap, this.icon, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
        color: backgroundColor ?? Colors.white,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: icon,
      ),
    );
  }
}
