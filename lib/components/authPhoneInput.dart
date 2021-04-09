import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class AuthPhoneInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool isEnabled;
  final String initialValue;
  final TextEditingController controller;
  const AuthPhoneInput(
      {Key key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.isEnabled = true,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      initialValue: initialValue,
      keyboardType: TextInputType.phone,
      onSaved: onChanged,
      style: TextStyle(
          color: Color(0xff071232),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 16.0, context)),
      cursorColor: Color(0xff245DE8),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: Color(0xffF3F4F8),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color(0xff828A95), fontSize: sizer(true, 16.0, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xff245DE8),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
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
