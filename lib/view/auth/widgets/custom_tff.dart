import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindglowequinox/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;

  final String? Function(String?)? validator; 

  const CustomTextField({
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: CupertinoColors.lightBackgroundGray,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Appcolor.gentleGreen),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10)
      ),
    );
  }
}
