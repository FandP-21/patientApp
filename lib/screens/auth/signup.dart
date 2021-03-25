import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/screens/auth/components/verifyEnterOtp.dart';
import 'components/signup.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:thcMobile/provider/user.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);
  final String title;
  // final String mobileNumber;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> registerFn(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)
      setState(() {
        _loading = true;
      });
    String _baseUrl = "https://thc2020.herokuapp.com/";
    var responseJson;
    Response response;
    Dio dio = new Dio();
    print(body);
    response = await dio
        .post(
      _baseUrl + "patient/",
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
        .catchError(
      (e) {
        if (mounted)
          setState(() {
            _loading = false;
          });
        print(e.response.data);
        var message = '';
        if (e.response.data['detail'] != null) {
          message = e.response.data['detail'];
        } else {
          message = e.response.data
              .toString()
              .substring(1, e.response.data.length - 1);
        }
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
    if (mounted)
      setState(() {
        _loading = false;
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
      var authResponse = await http.get(
          "https://thc2020.herokuapp.com/patient-list/${responseJson['patient_id'].toString()}/",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + responseJson['access_token']
          });
      Provider.of<UserModel>(context, listen: false)
          .setPatient(authResponse.body);
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyEnterOtpBody(
                  scaffoldKey: _scaffoldKey,
                  isLogin: false,
                  firstName: responseJson['data']['first_name'])));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SignUpBody(loading: _loading, registerFn: registerFn));
  }
}
