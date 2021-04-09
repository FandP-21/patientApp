import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import '../dashboard/index.dart';

class AppointmentSuccess extends StatefulWidget {
  AppointmentSuccess({Key key, this.title, this.customTitle, this.customAction})
      : super(key: key);
  final String title, customTitle;
  final GestureTapCallback customAction;

  @override
  _AppointmentSuccessState createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> {
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
                    top: 20,
                    bottom: sizer(false, 134, context),
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Material(
                              color: Color(0xffF3F4F8),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dashboard(
                                            loading: false,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Icon(Icons.cancel,
                                            color: Color(0xff071232),
                                            size: 18)),
                                  )))
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(27.5),
                              decoration: BoxDecoration(
                                  color: Color(0xfff4f4f8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Image.asset(
                                'assets/images/appointmentGreenSmall.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.contain,
                              )))
                        ]),
                        SizedBox(height: 26),
                        Text(
                          widget.customTitle ??
                              'Your appointment has been scheduled successfully',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color(0xff071232),
                              fontSize: sizer(true, 16.0, context)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    ButtonBlue(
                        onPressed: widget.customAction ??
                            () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                      loading: false,
                                    ),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                        title: 'SET REMINDER'),
                  ],
                ))));
  }
}
