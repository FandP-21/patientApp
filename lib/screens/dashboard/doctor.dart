import 'package:flutter/material.dart';
import 'components/doctor.dart';

class Doctor extends StatefulWidget {
  Doctor({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
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
    return DoctorBody();
  }
}
