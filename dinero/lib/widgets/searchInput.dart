import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  SearchInput({this.hint, this.controller});
  final String hint;
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
        prefixIcon: Icon(
          Icons.search,
          color: white,
          size: 24,
        ),
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        hintText: hint,
        hintStyle: TextStyle(
          color: white,
          fontSize: bodyText,
          fontWeight: FontWeight.w400,
        ),
      ),
      controller: controller,
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.text,
      cursorColor: white,
      style: TextStyle(
        color: white,
        fontSize: largeText,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
