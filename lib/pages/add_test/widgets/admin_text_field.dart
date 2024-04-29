import 'package:flutter/material.dart';

class AdminTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefix;
  final Widget? suffix;

  const AdminTextField({
    super.key,
    this.hintText,
    this.controller,
    this.prefix, this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          prefixIcon: prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    prefix!,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff005898)),
                  ),
                )
              : null,
          suffixIcon: suffix,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffFFD600),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
