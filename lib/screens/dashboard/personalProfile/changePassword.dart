import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/authPasswordInput.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/provider/user.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController oldPassword = new TextEditingController();

  final TextEditingController newPassword = new TextEditingController();
  final TextEditingController newPasswordCheck = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> changePassword() async {
    setState(() => loading = true);
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String mainId = Provider.of<UserModel>(context, listen: false).mainId;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response;
    Map<String, dynamic> body = {
      "pk": mainId,
      "old_password": oldPassword.text,
      "new_password": newPassword.text,
    };
      try {
        response = await http.patch(url + 'change-password/',
            body: body,
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            });
        var responseData = jsonDecode(response.body);
          if (responseData['status'] == "success"){
            Navigator.pop(context);
            oldPassword.clear();
            newPassword.clear();
            newPasswordCheck.clear();
            Fluttertoast.showToast(msg:  responseData['message']);
          }else{
            Fluttertoast.showToast(msg: responseData['old_password'][0]);
          }
        print(response.body);
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e)));
      }
  }

  @override
  void dispose() {
    newPassword.dispose();
    oldPassword.dispose();
    newPasswordCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 50, context), left: 20, right: 20),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              BackButtonWhite(
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          HeaderText(title: 'Change Password'),
                          SizedBox(height: 38),
                          Expanded(
                            child: customForm(),
                          )
                        ])))));
  }

  Widget customForm() {
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: oldPassword,
                      hintText: 'Enter current password',
                      onChanged: (text) {}),
                ),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: newPassword,
                      hintText: 'Enter new password',
                      onChanged: (text) {}),
                ),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: newPasswordCheck,
                      hintText: 'Reenter new password',
                      onChanged: (text) {}),
                ),
              ],
            ),
            ButtonBlue(onPressed: () {
              if (oldPassword.text.isEmpty){
                Fluttertoast.showToast(msg: "Please Enter Old Password.");
              }else if (oldPassword.text.length < 8){
                Fluttertoast.showToast(msg: "Old Password length must be 8 character.");
              }else if (newPassword.text.isEmpty){
                Fluttertoast.showToast(msg: "Please Enter New Password.");
              }
              else if (newPassword.text.length <8){
                Fluttertoast.showToast(msg: "New Password length must be 8 characters.");
              }else if (newPasswordCheck.text.isEmpty){
                Fluttertoast.showToast(msg: "Please Enter Confirm New Password.");
              }
              else if (newPasswordCheck.text.length < 8){
                Fluttertoast.showToast(msg: "Confirm New Password length must be 8 characters.");
              }else if (newPasswordCheck.text != newPassword.text){
                Fluttertoast.showToast(msg: "New Password & Confirm Password is not same.");
              }else {
                changePassword();
              }

            }, title: 'CHANGE PASSWORD'),
          ],
        ));
  }
}
