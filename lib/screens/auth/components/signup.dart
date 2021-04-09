import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/authPasswordInput.dart';
import 'package:thcMobile/components/authEmailInput.dart';
import 'package:thcMobile/components/authPhoneInput.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({Key key, this.title, this.registerFn, this.loading})
      : super(key: key);
  final String title;
  final Function registerFn;
  final bool loading;

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String email;
  String phoneNo;
  String password;
  String firstName, lastName;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // if (Provider.of<UserModel>(context, listen: false).mobileNumber != null &&
    //     Provider.of<UserModel>(context, listen: false).mobileNumber.length >
    //         0) {
    //   if (mounted)
    //     setState(() {
    //       phoneNo = Provider.of<UserModel>(context, listen: false).mobileNumber;
    //     });
    // } else {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(builder: (_) => VerifyBody(isLogin: false)),
    //   );
    // }
  }

  void preRegister() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        print('dd');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Invalid email',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      } else {
        Map<String, dynamic> body = {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNo
        };

        widget.registerFn(body);
      }
    } else {
      if (mounted)
        setState(() {
          _autoValidate = true;
        });
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
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
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    //     color: Color(0xffE7EEFF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'LOGIN',
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                      HeaderText(title: 'Welcome,'),
                      SizedBox(height: sizer(false, 7, context)),
                      Text('Create an account',
                          style: TextStyle(
                              color: Color(0xff071232), fontSize: 28)),
                      SizedBox(height: sizer(false, 50, context)),
                      new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: customForm(),
                      )
                    ]),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: AuthTextInput(
                        hintText: 'First Name',
                        onChanged: (text) {
                          firstName = text;
                        })),
                SizedBox(width: 16.0),
                Expanded(
                  child: AuthTextInput(
                      hintText: 'Last Name',
                      onChanged: (text) {
                        lastName = text;
                      }),
                )
              ],
            )),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(
              hintText: 'Email Address',
              onChanged: (text) {
                email = text;
              }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthPhoneInput(
              isEnabled: true,
              controller: _phoneNumberController,
              // initialValue: widget.mobileNumber,
              hintText: 'Phone number',
              onChanged: (text) {
                phoneNo = text;
              }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 116, context)),
          child: AuthPasswordInput(
              hintText: 'Create a Password',
              onChanged: (text) {
                password = text;
              }),
        ),
        ButtonBlue(
            onPressed: () {
              // _phoneNumberController.text = await _autoFill.hint;
              preRegister();
            },
            title: 'SIGN UP'),
        SizedBox(height: sizer(false, 32, context)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By signing up you agree to our ',
              style: TextStyle(
                  color: Color(0xff828A95), fontSize: sizer(true, 14, context)),
              children: <TextSpan>[
                TextSpan(
                    text: 'terms of service ',
                    style: TextStyle(color: Color(0xff245de8))),
                TextSpan(text: '& '),
                TextSpan(
                    text: 'privacy policy ',
                    style: TextStyle(color: Color(0xff245de8)))
              ],
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
