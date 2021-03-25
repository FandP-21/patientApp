import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/authEmailInput.dart';
import 'package:thcMobile/components/authPhoneInput.dart';
import './components/greenMeterBox.dart';
import 'enterInfoB.dart';

class EnterInfoA extends StatefulWidget {
  EnterInfoA(
      {Key key,
      @required this.title,
      @required this.hasPlan,
      @required this.hmoId,
      @required this.duration,
      @required this.sixMonthsPrice,
      @required this.oneYearPrice,
      @required this.identifier,
      @required this.hmoPlanId})
      : super(key: key);
  final String title;
  final bool hasPlan;
  final String hmoId;
  final String hmoPlanId;
  final String duration;
  final String sixMonthsPrice, oneYearPrice, identifier;

  @override
  _EnterInfoAState createState() => _EnterInfoAState();
}

class _EnterInfoAState extends State<EnterInfoA> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstName = new TextEditingController();
  final TextEditingController lastName = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController phoneNumber = new TextEditingController();
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

  String _dateOfBirth = "D.O.B";
  String _genotype = "Genotype";

  void handleNavigate() {
    if (phoneNumber.text.isNotEmpty)
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => EnterInfoB(
                  title: widget.title,
                  hasPlan: widget.hasPlan,
                  hmoId: widget.hmoId,
                  hmoPlanId: widget.hmoPlanId,
                  duration: widget.duration,
                  oneYearPrice: widget.oneYearPrice,
                  sixMonthsPrice: widget.sixMonthsPrice,
                  identifier: widget.identifier,
                )),
      );
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("All fields are required!",
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ))));
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('dd-MM-yy');
    return formatter.format(dateTime);
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
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
                  // right: sizer(true, 20, context),
                  bottom: 30),
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
                  SizedBox(height: 25),
                  HeaderText(title: widget.title),
                  SizedBox(
                    height: 5,
                  ),
                  SubText(
                      isCenter: false,
                      title:
                          'Fill in your information to complete your registration'),
                  SizedBox(height: 50),
                  new Form(
                    key: _formKey,
                    child: customForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customForm() {
    return Padding(
        padding: EdgeInsets.only(right: 20),
        child: Column(
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
                            controller: firstName.text.isEmpty
                                ? TextEditingController(
                                    text: patient['user']['first_name'])
                                : firstName,
                            hintText: 'First Name',
                            onChanged: (text) {})),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: AuthTextInput(
                          controller: lastName.text.isEmpty
                              ? TextEditingController(
                                  text: patient['user']['last_name'])
                              : lastName,
                          hintText: 'Last Name',
                          onChanged: (text) =>
                              setState(() => _genotype = text)),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: DropdownWidget(
                        title: _genotype,
                        store: ["AA", "AS", "SS"],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      child: GestureDetector(
                          child: DropdownWidget(
                            title: _dateOfBirth,
                            store: [],
                          ),
                          onTap: () => showDatePicker(
                                context: context,
                                initialDate: DateTime(DateTime.now().year - 1,
                                    DateTime.now().month, DateTime.now().day),
                                firstDate: DateTime(1960, 1, 1),
                                lastDate: DateTime(DateTime.now().year - 1,
                                    DateTime.now().month, DateTime.now().day),
                              ).then((value) => setState(() => _dateOfBirth =
                                  formatDateString(value.toString())))),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
              child: AuthPhoneInput(
                  controller: phoneNumber,
                  hintText: 'Phone number',
                  onChanged: (text) {}),
            ),
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
              child: AuthEmailInput(
                  controller: email.text.isEmpty
                      ? TextEditingController(text: patient['user']['email'])
                      : email,
                  hintText: 'Email Address',
                  onChanged: (text) {}),
            ),
            SizedBox(height: 30),
            GreenMeterBox(position: 0.6),
            SizedBox(height: 30),
            ButtonBlue(onPressed: handleNavigate, title: 'NEXT'),
            SizedBox(height: sizer(false, 32, context)),
            SizedBox(height: 10)
          ],
        ));
  }
}
