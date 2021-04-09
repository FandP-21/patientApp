import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'enterInfoA.dart';
import 'dart:convert';

class HaveAPlan extends StatefulWidget {
  HaveAPlan({
    this.title,
  });
  final String title;

  @override
  _HaveAPlanState createState() => _HaveAPlanState();
}

class _HaveAPlanState extends State<HaveAPlan> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> patient = {};
  @override
  void initState() {
    super.initState();
    this._getPatient();
  }

  void _getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      patient = jsonDecode(prefs.getString("patient"));
    });
    print(jsonDecode(prefs.getString("patient")));
  }

  TextEditingController fName = new TextEditingController();
  TextEditingController lName = new TextEditingController();
  TextEditingController planNumber = new TextEditingController();

  Future<Null> validateAndNavigate() {
    if (planNumber.text.isNotEmpty && planNumber.text.length >= 1)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EnterInfoA(
            title: widget.title,
            hasPlan: true,
          ),
        ),
      );
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Invalid input! Please check again.",
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ))));
  }

  @override
  void dispose() {
    fName.dispose();
    lName.dispose();
    planNumber.dispose();
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
                  SizedBox(height: sizer(false, 25, context)),
                  HeaderText(title: widget.title),
                  SizedBox(
                    height: 8,
                  ),
                  SubText(isCenter: false, title: 'Enter health plan details'),
                  SizedBox(
                      height: sizer(false,
                          MediaQuery.of(context).size.height * 0.1, context)),
                  AuthTextInput(
                    hintText: "First name",
                    controller: fName.text.isEmpty
                        ? TextEditingController(
                            text: patient['user']['first_name'])
                        : fName,
                  ),
                  SizedBox(height: 15),
                  AuthTextInput(
                    hintText: "Last name",
                    controller: lName.text.isEmpty
                        ? TextEditingController(
                            text: patient['user']['last_name'])
                        : lName,
                  ),
                  SizedBox(height: 15),
                  AuthTextInput(
                    hintText: "Plan number",
                    controller: planNumber,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                      height: sizer(false,
                          MediaQuery.of(context).size.height * 0.1, context)),
                  ButtonBlue(
                    title: 'NEXT',
                    onPressed: validateAndNavigate,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
