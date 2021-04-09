import 'package:dinero/helpers/main.dart';
import 'package:dinero/widgets/actionButton.dart';
import 'package:dinero/widgets/emailInput.dart';
import 'package:dinero/widgets/passwordInput.dart';
import 'package:dinero/widgets/phoneInput.dart';
import 'package:dinero/widgets/textInput.dart';
import 'package:flutter/material.dart';

class Apply extends StatelessWidget {
  Apply(
      {this.title,
      this.name,
      this.bio,
      this.location,
      this.address,
      this.email,
      this.phone});
  final String title, bio, name, phone, location, address, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlack,
      appBar: null,
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: deepGreen,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Update Profile",
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w400,
                  fontSize: largeText + 2),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextInput(
                    hint: name,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EmailInput(
                    hint: email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PhoneInput(
                    hint: phone,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInput(
                    hint: title,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInput(
                    hint: bio,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInput(
                    hint: address,
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInput(
                    hint: location,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Actionbutton(
                    title: "Update",
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: white.withOpacity(0.08),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  PasswordInput(
                    hint: "Old password",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PasswordInput(
                    hint: "New password",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PasswordInput(hint: "Re-enter New password"),
                  SizedBox(
                    height: 25,
                  ),
                  Actionbutton(
                    title: "Change Password",
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
