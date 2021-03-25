import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/screens/dashboard/index.dart';
import '../components/menuDropdown.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:provider/provider.dart';
import 'index.dart';

class Referral extends StatefulWidget {
  Referral({
    Key key,
  }) : super(key: key);

  @override
  _ReferralState createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  String description = '';
  bool _autoValidate = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 50, context),
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context)),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BackButtonWhite(
                            onPressed: () {},
                          ),
                        ],
                      ), //
                      SizedBox(height: sizer(false, 15, context)),
                      HeaderText(title: 'Request a referral'),
                      SizedBox(height: 5),
                      Text('Request a hospital referral from your doctor',
                          style: TextStyle(
                              color: Color(0xff8E919C),
                              fontSize: sizer(true, 16.0, context))),
                      SizedBox(height: 26),
                      MenuDropdown(title: 'Dr Alice Agu', onPressed: () {}),
                      Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: MultiInput(
                            onChanged: (text) {
                              description = text;
                            },
                            hintText: 'Reason for referral',
                          )),
                      Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 30),
                              width: MediaQuery.of(context).size.width,
                              child: ButtonBlue(
                                title: 'SUBMIT',
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Dashboard(
                                            loading: false,
                                          )));
                                },
                              )))
                    ]),
              )),
            )),
            isLoading: loading));
  }
}
