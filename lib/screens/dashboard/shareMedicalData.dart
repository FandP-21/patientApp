import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/screens/dashboard/medicalRecords/requestMedicalRecordsB.dart';

class ShareMedicalData extends StatefulWidget {
  ShareMedicalData({Key key, this.title, @required this.doctor})
      : super(key: key);
  final String title;
  final Doctor doctor;

  @override
  _ShareMedicalDataState createState() => _ShareMedicalDataState();
}

class _ShareMedicalDataState extends State<ShareMedicalData> {
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
    return RequestMedicalRecordsB(
      doctor: widget.doctor.id,
      isRequest: false,
      onShare: () => {},
      buttonText: "Share",
      hasIcon: true,
      subTitle: "Choose what you'd like to share",
      hospital: 1,
      patient: 1,
      title: "Share Medical Data",
    );
  }
}
