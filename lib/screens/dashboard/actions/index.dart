import 'package:flutter/material.dart';
import 'package:thcMobile/components/twentyText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/styles.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/screens/dashboard/actions/bookAppointmentHospital.dart';
import 'package:thcMobile/screens/dashboard/actions/eConsultation.dart';
import '../medicalRecords/requestMedicalRecordsA.dart';
import './requestTestKit.dart';
import 'requestTestKit.dart';
import 'diagnosticTest.dart';
import 'package:thcMobile/screens/dashboard/actions/homeService/index.dart';

class ActionsIndex extends StatefulWidget {
  ActionsIndex({Key key, this.title, this.hospital, this.doctor})
      : super(key: key);
  final String title;
  final Doctor doctor;
  final Hospital hospital;

  @override
  _ActionsIndexState createState() => _ActionsIndexState();
}

class _ActionsIndexState extends State<ActionsIndex> {
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
                        Text(
                          'Actions',
                          style: TextStyle(
                            color: black,
                            fontSize: pixel28,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(height: 23),
                        GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => RequestTestKit())),
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: blue.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Image.asset(
                                        'assets/images/referralIcon.png'),
                                  ),
                                  SizedBox(height: 15),
                                  detailsBox(
                                    'Health check home test kit',
                                    'Buy from a range of available options',
                                  )
                                ],
                              ),
                            )),
                        GestureDetector(
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffDDD6FF),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Center(
                                      child: Image.asset(
                                          'assets/images/eCIcon.png'),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  detailsBox(
                                      'E-consultation',
                                      'Consult with your registered hospital or practice by filling out a form',
                                      false)
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EConsulattion()))),
                        GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BookAppointmentHospital(
                                          title: '',
                                          hospital: widget.hospital,
                                        ))),
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(68, 255, 255, 0.15),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/physicalIcon.png',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  detailsBox('Book physical appointment',
                                      'At your registered hospital or practice')
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => DiagnosticTest(title: ''))),
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 113, 68, 0.15),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/labIcon.png',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  detailsBox('Book a test/lab examination',
                                      'At your preferred diagnostic centre or hospital')
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        RequestMedicalRecordsA(title: ''))),
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xfff3d3d7),
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.favorite,
                                          color: Color(0xffF01919), size: 22)),
                                  SizedBox(height: 15),
                                  detailsBox('Request medical records',
                                      'From your registered hospital or practice')
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => HomeServiceRequest(
                                          title: '',
                                          doctor: widget.doctor,
                                        ))),
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: roundedF3Box,
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 13, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 113, 68, 0.15),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/homeServiceIcon.png',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  detailsBox(
                                      'Home service request',
                                      'Request home service from your registered hospital or practice',
                                      false)
                                ],
                              ),
                            )),
                      ]),
                )))));
  }

  Widget detailsBox(String title, String details, [bool spaced]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TwentyText(
          title: title,
        ),
        spaced == null ? SizedBox(height: 10) : SizedBox(),
        Text(
          details,
          style: TextStyle(
            color: inputGrey,
            fontSize: pixel16,
            height: spaced == null ? 1.2 : 1.1,
            fontWeight: normal,
          ),
        )
      ],
    );
  }
}
