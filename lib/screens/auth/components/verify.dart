import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/authPhoneInput.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/auth/signup.dart';
import 'package:thcMobile/screens/dashboard/index.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:loading_overlay/loading_overlay.dart';

class VerifyBody extends StatefulWidget {
  VerifyBody({Key key, @required this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  _VerifyBodyState createState() => _VerifyBodyState();
}

class _VerifyBodyState extends State<VerifyBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String mobileNumber;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String smsOTP;
  String verificationId;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _start = 60;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  Future<dynamic> saveMobileNumber(body) async {
    setState(() {
      loading = true;
    });
    String _baseUrl = "https://thc2020.herokuapp.com/";
    String _id = Provider.of<UserModel>(context, listen: false).id;
    var responseJson;
    Response response;
    Dio dio = new Dio();

    response = await dio
        .patch(
      _baseUrl + "patient/" + _id,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Connection": 'keep-alive'
          }),
    )
        .catchError((e) {
      setState(() {
        loading = false;
      });
      print(e.response.data);
      var message = '';
      if (e.response.data['detail'] != null) {
        message = e.response.data['detail'];
      } else {
        message =
            e.response.data.toString().substring(1, e.response.data.length - 1);
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    });
    setState(() {
      loading = false;
    });
    responseJson = response.data;
    if (response.statusCode != 201) {
      print(response.statusCode);
      var message = '';
      if (response.data['email'] != null) {
        message = response.data['email']
            .toString()
            .substring(1, response.data['email'].toString().length - 1);
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    } else {
      Provider.of<UserModel>(context, listen: false)
          .setId(responseJson['data']['patient_id'].toString());
      Provider.of<UserModel>(context, listen: false)
          .setMainId(responseJson['data']['id'].toString());
      Provider.of<UserModel>(context, listen: false)
          .setToken(responseJson['data']['access_token']);
      Provider.of<UserModel>(context, listen: false)
          .setName(responseJson['data']['first_name']);
      print(responseJson);
      return true;
    }
  }

  void preVerify() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      verifyFn();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> verifyFn() async {
    setState(() {
      loading = true;
    });
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+234' +
              this.mobileNumber.substring(1), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            setState(() {
              loading = false;
            });
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                'A unexpected error has taken place. Please confirm mobile number and retry',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              elevation: 0.0,
            ));
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 10),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
            _auth
                .signInWithCredential(phoneAuthCredential)
                .then((UserCredential result) async {
              if (result.user != null) {
                Provider.of<UserModel>(context, listen: false)
                    .setMobileNumber('+234' + this.mobileNumber.substring(1));
                setState(() {
                  loading = false;
                });
                if (widget.isLogin) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Dashboard(
                      loading: false,
                    ),
                  ));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SignUp(),
                  ));
                }
              } else {
                setState(() {
                  loading = false;
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'A unexpected error has taken place',
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  elevation: 0.0,
                ));
              }
            }).catchError((e) {
              setState(() {
                loading = false;
              });
              print(e);
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            setState(() {
              loading = false;
            });
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                exception.message,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              elevation: 0.0,
            ));
          });
    } catch (e) {
      setState(() {
        loading = false;
      });
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Invalid Code',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          elevation: 0.0,
        ));
        break;
      default:
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            error.message,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          elevation: 0.0,
        ));

        break;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: verificationId == null || verificationId.length > 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: new SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: sizer(false, 100, context),
                                  left: 20,
                                  right: 20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/brownHand.png',
                                          width: 28,
                                          height: 28,
                                        ),
                                        Spacer(
                                          flex: 1,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: sizer(false, 7, context)),
                                    HeaderText(title: 'Hi ' + ','),
                                    SizedBox(height: sizer(false, 7, context)),
                                    Text('Please verify your account',
                                        style: TextStyle(
                                            color: Color(0xff071232),
                                            fontSize: 28)),
                                    SizedBox(height: sizer(false, 41, context)),
                                    SubText(
                                      title:
                                          'Enter otp sent to your mobile number',
                                      isCenter: false,
                                    ),
                                    SizedBox(height: sizer(false, 96, context)),
                                    new Form(
                                      key: _formKey,
                                      autovalidate: _autoValidate,
                                      child: customForm(),
                                    )
                                  ]))))
                  // : VerifyEnterOtpBody(
                  //     resendToken: () {
                  //       verifyFn();
                  //     },
                  //     otp: verificationId,
                  //     start: _start,
                  //     isLogin: widget.isLogin,
                  //     mobileNumber: '+234' + this.mobileNumber.substring(1))),
                  : SizedBox()),
          isLoading: loading,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          child: AuthPhoneInput(
              hintText: 'Enter Phone Number(0**********)',
              onChanged: (text) {
                mobileNumber = text;
              }),
        ),
        // ResendCodeTimer(loading: widget.loading,
        // resendToken: widget.resendToken,
        // start: widget.start),
        SizedBox(height: sizer(false, 229, context)),
        ButtonBlue(
            onPressed: () {
              preVerify();
              // Navigator.of(context).push(
              //                               MaterialPageRoute(
              //                                   builder: (_) => RegisterSuccess()),
              //                             );
            },
            title: 'SEND OTP'),
      ],
    );
  }
}
