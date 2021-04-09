import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:http/http.dart' as http;
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController email = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _passwordResetRequest() {
    if (email.text.isEmpty)
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Email is required!")));
    try {
      var response = http.post('thc2020.herokuapp.com/api/password_reset/',
          body: {'email': email.text});
      Fluttertoast.showToast(msg: "Please check your mail for reset link");
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Failed to send request!")));
    }
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SizedBox(),
        leading: SizedBox(),
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: sizer(false, 80, context),
            left: sizer(true, 20, context),
            right: sizer(true, 20, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Password Reset",
              style: TextStyle(
                fontSize: pixel28,
                fontWeight: bold,
              ),
            ),
            vertical(20, true, context),
            AuthTextInput(
                controller: email, enabled: true, hintText: 'Email address'),
            vertical(20, false, context),
            ButtonBlue(
                title: 'RESET PASSWORD', onPressed: _passwordResetRequest),
          ],
        ),
      ),
    );
  }
}
