import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/auth/components/passwordReset.dart';
import 'package:thcMobile/screens/auth/signup.dart';
import 'package:thcMobile/components/authPasswordInputTest.dart';
import 'package:thcMobile/components/authEmailInput.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignInBody extends StatefulWidget {
  SignInBody({Key key, this.title, this.loginFn, this.loading})
      : super(key: key);
  final String title;
  final Function loginFn;
  final bool loading;

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> preLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String, dynamic> body = {
        'email': _email.text,
        'password': _password.text,
      };
      prefs.setString("email", _email.text);
      prefs.setString("password", _password.text);
      widget.loginFn(body);
    } else {
      if (mounted)
        setState(() {
          _autoValidate = true;
        });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingOverlay(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 80, context),
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/brownHand.png',
                          width: 28,
                          height: 28,
                        ),
                        Material(
                            color: Color(0xffE7EEFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => SignUp(
                                            title: 'admin',
                                          )),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  //    color: Color(0xffE7EEFF),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          color: Color(0xff245DE8),
                                          fontSize: sizer(true, 14, context),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Color(0xff245DE8),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 10.0,
                                        color: Colors.white,
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(height: sizer(false, 7, context)),
                    HeaderText(title: 'Welcome Back,'),
                    SizedBox(height: sizer(false, 7, context)),
                    Text('Sign in',
                        style:
                            TextStyle(color: Color(0xff071232), fontSize: 28)),
                    SizedBox(height: sizer(false, 93, context)),
                    new Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: customForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading: widget.loading,
      ),
    );
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(controller: _email, hintText: 'Email Address'),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthPasswordInputTextTest(
              controller: _password, hintText: 'Password'),
        ),
        Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'forgot password?',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordReset())),
                  style: TextStyle(
                    color: blue,
                    fontSize: pixel14,
                    fontWeight: FontWeight.w400,
                  ))
            ]))),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 100, context)),
        ),
        ButtonBlue(
            onPressed: () {
              preLogin();
            },
            title: 'LOG IN'),
      ],
    );
  }
}
