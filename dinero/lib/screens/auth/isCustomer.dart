import 'dart:convert';
import 'package:dinero/main.dart';
import 'package:dinero/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dinero/helpers/main.dart';
import 'package:dinero/widgets/actionButton.dart';
import 'package:dinero/widgets/emailInput.dart';
import 'package:dinero/widgets/passwordInput.dart';
import 'package:dinero/widgets/phoneInput.dart';
import 'package:dinero/widgets/textInput.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dinero/provider/appState.dart';

class IsCustomer extends StatefulWidget {
  IsCustomer(
      {@required this.callback, @required this.screen, @required this.loading});
  final Function callback;
  String screen;
  final VoidCallback loading;
  @override
  _IsCustomerState createState() => _IsCustomerState();
}

class _IsCustomerState extends State<IsCustomer> {
  bool extend = false;
  String authMethod = '--- Choose to select ---';
  bool selected = false;
  String screen = 'login';
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController fullName = new TextEditingController();
  final TextEditingController phoneNumber = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  final TextEditingController password2 = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> handleLogin() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      widget.callback("Both fields are required!");
      return;
    }
    Map<String, dynamic> body = {
      "email": email.text,
      "password": password.text
    };
    widget.loading();
    var response = await http.post(url + 'user/signin/', body: body);
    var responseJson = jsonDecode(response.body);

    if (responseJson["non_field_errors"] != null)
      widget.callback(responseJson["non_field_errors"][0]);
    else {
      Provider.of<AppState>(context, listen: false)
          .setToken(responseJson["responseJson"]);
      Provider.of<AppState>(context, listen: false)
          .setCustomer(responseJson["user"]["is_customer"]);
      Provider.of<AppState>(context, listen: false)
          .setVendor(responseJson["user"]["is_vendor"]);
      Provider.of<AppState>(context, listen: false)
          .setEmail(responseJson["user"]["mail"]);
      Provider.of<AppState>(context, listen: false)
          .setId(responseJson["user"]["id"]);
      Provider.of<AppState>(context, listen: false)
          .setName(responseJson["user"]["name"]);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    personality: "customer",
                  )));
    }
    widget.loading();
  }

  Future<Null> handleSignUp() async {
    if (fullName.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        password2.text.isEmpty ||
        address.text.isEmpty) {
      widget.callback("All fields are required!");
      return;
    }
    Map<String, dynamic> body = {
      "username": fullName.text.split(' ')[0].toString(),
      "email": email.text,
      "password1": password.text,
      "password2": password2.text,
      "name": fullName.text,
      "address": address.text,
    };
    widget.loading();
    try {
      var response = await http.post(url + 'user/signup/customer/', body: body);
      var responseJson = jsonDecode(response.body);
      widget.loading();
      if (responseJson[responseJson.keys.first][0] ==
          "Verification e-mail sent.") {
        widget.callback("Verification e-mail sent.");
        Future.delayed(Duration(seconds: 2),
            () => setState(() => widget.screen = 'login'));
      } else {
        widget.callback(responseJson[responseJson.keys.first][0]);
      }
    } on FormatException {
      widget.loading();
      widget.callback("SMTP error - failed to send verification email.");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 40,
        ),
        widget.screen == 'login'
            ? Text(
                "LOGIN TO\nYOUR ACCOUNT",
                style: TextStyle(
                  color: defaultGreen,
                  fontWeight: FontWeight.w300,
                  fontSize: largeText,
                ),
              )
            : Text(
                "CREATE\nACCOUNT",
                style: TextStyle(
                  color: defaultGreen,
                  fontWeight: FontWeight.w300,
                  fontSize: largeText,
                ),
              ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Customer",
          style: TextStyle(
            color: defaultGreen,
            fontWeight: FontWeight.w400,
            fontSize: massiveText,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        widget.screen == 'login'
            ? EmailInput(
                hint: "Email Address",
                controller: email,
                inputAction: TextInputAction.next,
              )
            : SizedBox(),
        widget.screen == 'login'
            ? SizedBox(
                height: 15,
              )
            : SizedBox(),
        widget.screen == 'login'
            ? PasswordInput(
                hint: "Password",
                controller: password,
                inputAction: TextInputAction.go,
              )
            : SizedBox(),
        widget.screen == 'login'
            ? SizedBox(
                height: 30,
              )
            : SizedBox(),
        widget.screen == 'login'
            ? Actionbutton(
                onPressed: handleLogin,
                title: "LOGIN",
              )
            : SizedBox(),
        widget.screen == 'login'
            ? SizedBox(
                height: 15,
              )
            : SizedBox(),
        widget.screen == 'login'
            ? Text(
                "Forgot password?",
                style: TextStyle(
                  color: defaultGreen,
                  fontSize: bodyText,
                  fontWeight: FontWeight.w400,
                ),
              )
            : SizedBox(),
        widget.screen == 'signup'
            ? Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextInput(
                        hint: "Name",
                        controller: fullName,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      EmailInput(
                        hint: "Email Address",
                        controller: email,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PhoneInput(
                        hint: "Phone Number",
                        controller: phoneNumber,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextInput(
                        hint: "Address",
                        controller: address,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordInput(
                        hint: "Password",
                        controller: password,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordInput(
                        hint: "Confirm Password",
                        controller: password2,
                        inputAction: TextInputAction.go,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.45),
                        child: Actionbutton(
                          title: "Submit",
                          onPressed: handleSignUp,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
