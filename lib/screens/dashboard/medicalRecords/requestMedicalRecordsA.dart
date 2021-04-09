import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/authSelectInput.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/medicalRecords/requestMedicalRecordsSuccess.dart';
import 'requestMedicalRecordsB.dart';

class RequestMedicalRecordsA extends StatefulWidget {
  RequestMedicalRecordsA({Key key, this.title, this.doctor}) : super(key: key);
  final Doctor doctor;
  final String title;

  @override
  _RequestMedicalRecordsAState createState() => _RequestMedicalRecordsAState();
}

class _RequestMedicalRecordsAState extends State<RequestMedicalRecordsA> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController controller = new TextEditingController();
  var hospitalID = null;
  String _title = "Select Hospital to request records from";
  List hospitals = [];
  List ids = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('hospitals')) {
      var jsonData = jsonDecode(prefs.getString('hospitals'));
      for (var i = 0; i < jsonData.length; i++) {
        setState(() {
          ids.add(jsonData[i]['id']);
          hospitals.add(jsonData[i]['user']['username']);
        });
      }
    }
    this._fillData();
  }

  void _fillData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    try {
      var response = await http.get(url + "hospital/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      var jsonData = jsonDecode(response.body);
      ids = [];
      hospitals = [];
      for (var i = 0; i < jsonData.length; i++) {
        setState(() {
          ids.add(jsonData[i]['id']);
          hospitals.add(jsonData[i]['user']['username']);
        });
      }
      prefs.setString('hospitals', response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Request failed!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
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
                child: new SingleChildScrollView(
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
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Request medical records'),
                        SizedBox(height: sizer(false, 38, context)),
                        new Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: sizer(false, 16, context)),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: EdgeInsets.only(
                                      left: 15, top: 7, right: 10),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF3F4F8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      _title,
                                      style: TextStyle(
                                          color: Color(0xff828A95),
                                          fontFamily: 'SofiaPro',
                                          fontSize: sizer(true, 16.0, context)),
                                    ),
                                    items: hospitals.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                            value.toString().toUpperCase()),
                                        onTap: () {
                                          setState(() {
                                            _title =
                                                value.toString().toUpperCase();
                                            hospitalID =
                                                ids[hospitals.indexOf(value)];
                                          });
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    style: TextStyle(
                                        color: Color(0xff2254D3),
                                        fontFamily: 'SofiaPro',
                                        fontSize: 14),
                                    underline: SizedBox(),
                                    dropdownColor: Color(0xffF3F4F8),
                                    iconDisabledColor: Color(0xff2254D3),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: sizer(false, 16, context)),
                                child: AuthTextInput(
                                    hintText: 'Enter your patient ID',
                                    controller: controller,
                                    onChanged: (text) {}),
                              ),
                              ButtonBlue(
                                  onPressed: () {
                                    controller.text.isNotEmpty &&
                                            hospitalID != null
                                        ? Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => RequestMedicalRecordsB(
                                                doctor: widget.doctor.id,
                                                isRequest: true,
                                                buttonText: "SEND REQUEST",
                                                hasIcon: false,
                                                onShare: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RequestMedicalRecordsSuccess())),
                                                subTitle:
                                                    'Choose the data you\'d like to request',
                                                hospital: hospitalID,
                                                patient:
                                                    int.parse(controller.text),
                                                title:
                                                    'Request medical records')))
                                        : _scaffoldKey.currentState
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Both fields are required!",
                                                style: TextStyle(
                                                  fontSize: sizer(
                                                      true, 15.0, context),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                  title: 'NEXT'),
                              SizedBox(height: sizer(false, 32, context)),
                              SizedBox(height: 10)
                            ],
                          ),
                        )
                      ]),
                )))));
  }
}
