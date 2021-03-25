import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/screens/auth/signin.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class Loader extends StatefulWidget {
  Loader({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("groupChatIds", jsonEncode([]));
    String token = (prefs.getString('token') ?? '');
    if (token != '' && user.currentUser != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => Dashboard(
                  title: 'THC',
                  loading: true,
                )),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SignIn(title: 'THC')),
      );
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
      resizeToAvoidBottomPadding: false,
      body: SafeArea(child: Container()),
    );
  }
}
