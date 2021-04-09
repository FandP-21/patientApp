import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class RequestMedicalRecordsSuccess extends StatefulWidget {
  RequestMedicalRecordsSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestMedicalRecordsSuccessState createState() =>
      _RequestMedicalRecordsSuccessState();
}

class _RequestMedicalRecordsSuccessState
    extends State<RequestMedicalRecordsSuccess> {
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
            child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 176, context),
                    bottom: sizer(false, 134, context),
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/sendIcon.png',
                      width: 140,
                      height: 140,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 57),
                        child: Text(
                            'Your request has been sent, you will receive a notification once it is approved shortly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: sizer(true, 16.0, context))),
                      ),
                    ),
                    ButtonBlue(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(
                                  loading: false,
                                ),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        title: 'CONTINUE'),
                  ],
                ))));
  }
}
