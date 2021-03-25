import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  EmailInput({this.hint, this.controller, this.inputAction});
  final String hint;
  final TextInputAction inputAction;
  final TextEditingController controller;

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
      keyboardType: TextInputType.emailAddress,
      cursorColor: defaultGreen,
      style: TextStyle(
        color: defaultGreen,
        fontSize: bodyText,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
