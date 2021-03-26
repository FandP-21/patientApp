import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class AuthTextInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool enabled;
  final TextEditingController controller;
  final BorderSide border;
  final Color altTextColor;
  const AuthTextInput(
      {Key key,
      this.hintText,
      this.onChanged,
      this.controller,
      this.enabled,
      this.border,
      this.altTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onChanged,
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
          color: altTextColor ?? Color(0xff071232),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 16.0, context)),
      cursorColor: Color(0xff245DE8),
      enabled: enabled ?? true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: Color(0xffF3F4F8),
        hintText: hintText,
        errorMaxLines: 5,
        hintStyle: TextStyle(
            color: altTextColor ?? Color(0xff828A95),
            fontSize: sizer(true, 16.0, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xff245DE8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: border ??
              BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: border ??
              BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
        ),
        filled: true,
      ),
      validator: (val) {
        if (val.length == 0) {
          return hintText + " is required";
        } else {
          return null;
        }
      },
    );
  }
}
