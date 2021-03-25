import 'package:dinero/main.dart';
import 'package:flutter/material.dart';
import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/dashboard.dart';
import 'package:dinero/widgets/actionButton.dart';
import 'package:dinero/widgets/emailInput.dart';
import 'package:dinero/widgets/passwordInput.dart';
import 'package:dinero/widgets/phoneInput.dart';
import 'package:dinero/widgets/textInput.dart';
import 'package:http/http.dart' as http;


class IsVendor extends StatefulWidget {
  IsVendor(
      {@required this.screen, @required this.callback, @required this.loading});
  String screen;
  final Function callback;
  final VoidCallback loading;
  @override
  _IsVendorState createState() => _IsVendorState();
}

class _IsVendorState extends State<IsVendor> {
  bool extend = false;
  String authMethod = '--- Choose to select ---';
  bool selected = false;
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController fullName = new TextEditingController();
  final TextEditingController phoneNumber = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  final TextEditingController password2 = new TextEditingController();
  final TextEditingController idCardNumber = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() => widget.screen = "signup");
  }

  Future<Null> handleLogin() async {
    Map<String, dynamic> body = {};

    var response = await http.post(url + 'user/signin/', body: body);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  personality: "customer",
                )));
  }

  Future<Null> handleSignUp() async {
    Map<String, dynamic> body = {};

    var response = await http.post(url + 'user/signup/vendor/', body: body);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  personality: "customer",
                )));
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
          "Vendor",
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
            ? SizedBox(
                height: 15,
              )
            : SizedBox(),
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
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                              personality: "vendor",
                            ))),
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
                      PhoneInput(
                        hint: "ID Card number",
                        controller: idCardNumber,
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.45),
                        child: Actionbutton(
                          title: "Submit",
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                        personality: "vendor",
                                      ))),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
