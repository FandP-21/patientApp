import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({this.hint, this.controller, this.inputAction});
  final String hint;
  final TextEditingController controller;
  final TextInputAction inputAction;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        fillColor: white.withOpacity(0.05),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        hintText: hint,
        hintStyle: TextStyle(
          color: defaultGreen,
          fontSize: bodyText,
          fontWeight: FontWeight.w300,
        ),
      ),
      controller: controller,
      textInputAction: inputAction,
      obscureText: true,
      keyboardType: TextInputType.text,
      cursorColor: defaultGreen,
      style: TextStyle(
        color: defaultGreen,
        fontSize: bodyText,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
