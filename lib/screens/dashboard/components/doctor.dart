import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/patient.dart';
import 'goToDoctorBox.dart';
import 'appointmentBox.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/models/appointment.dart';
import '../doctorSearch.dart';
import '../appointments/index.dart';
import '../doctorInfo.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcMobile/provider/user.dart';
// import 'package:provider/provider.dart';

class DoctorBody extends StatefulWidget {
  DoctorBody({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DoctorBodyState createState() => _DoctorBodyState();
}

class _DoctorBodyState extends State<DoctorBody> {
  bool doctorsLoading = false;
  bool appointmentsLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var appointmentsData = [];
  var doctorsData = [];
  var patientData;

  @override
  void initState() {
    super.initState();
    this._getPatient();
    this._offlineData();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("upcomingAppointment") &&
        prefs.containsKey("yourDoctor")) {
      final String upcomingAppointments =
          prefs.getString('upcomingAppointment');
      final String yourDoctors = prefs.getString('yourDoctor');
      setState(() {
        appointmentsData = jsonDecode(upcomingAppointments);
        doctorsData = jsonDecode(yourDoctors);
      });
      print(doctorsData);
      this.getDoctorsData();
    } else {
      setState(() {
        appointmentsLoading = true;
      });
    }
    this.getDoctorsData();
  }

  Future<Null> _getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    patientData = jsonDecode(prefs.getString('patient'));
  }

  Future getDoctorsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    try {
      var response = await http.get(url + "doctors-of-patient/" + id + '/',
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      var responseX = await http.post(url + "upcoming-appointment/$id/",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      setState(() {
        doctorsData = jsonDecode(response.body);
        appointmentsData = jsonDecode(responseX.body);
        appointmentsLoading = false;
      });
      await prefs.setString('yourDoctor', response.body);
      await prefs.setString('upcomingAppointment', responseX.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
      setState(() {
        appointmentsLoading = false;
      });
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
      body: LoadingOverlay(
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: new SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 30, context),
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
                            BackButtonWhite(
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: sizer(false, 25, context)),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Doctors",
                                style: TextStyle(
                                  color: black,
                                  fontSize: pixel24,
                                  fontWeight: bold,
                                )),
                            Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              color: Color(0xff2254D3),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => DoctorSearch()),
                                  );
                                },
                                child: Container(
                                  width: 153,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 22.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xff2254D3),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'FIND A DOCTOR',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text("YOUR DOCTORS",
                            style: TextStyle(
                              color: inputGrey,
                              fontSize: pixel14,
                              fontWeight: normal,
                            )),
                        SizedBox(height: 16),
                        doctorsData.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: doctorsData.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return GoToDoctorBox(
                                      doctor:
                                          Doctor.fromJson(doctorsData[index]),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => DoctorInfo(
                                                  myId:
                                                      "${patientData['id'].toString()}",
                                                  myAvatar:
                                                      "${patientData['photo'] ?? ''}",
                                                  myName:
                                                      '${patientData['user']['name']}',
                                                  hasSubscribed: true,
                                                  myDoctor: true,
                                                  doctor: Doctor.fromJson(
                                                      doctorsData[index]))),
                                        );
                                      });
                                })
                            : EmptyData(
                                title: 'No doctors available', isButton: false),
                        SizedBox(height: 30),
                        Text("UPCOMING APPOINTMENTS",
                            style: TextStyle(
                              color: inputGrey,
                              fontSize: pixel14,
                              fontWeight: normal,
                            )),
                        SizedBox(height: 16),
                        Column(
                          children: <Widget>[
                            appointmentsData != []
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: appointmentsData.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return new AppointmentBox(
                                          isPrevious: false,
                                          appointment: Appointment.fromJson(
                                              appointmentsData[index]),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Appointments()),
                                            );
                                          });
                                    })
                                : EmptyData(
                                    title:
                                        'You have no upcoming appointments presently',
                                    isButton: false),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
          isLoading: appointmentsLoading),
    );
  }
}
