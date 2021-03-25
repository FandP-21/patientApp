import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class SetNotifications extends StatefulWidget {
  SetNotifications({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetNotificationsState createState() => _SetNotificationsState();
}

class _SetNotificationsState extends State<SetNotifications> {
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
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 124, context),
                        bottom: sizer(false, 134, context),
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/phoneNotifications.png',
                          width: 319,
                          height: 263,
                        ),
                        SizedBox(height: sizer(false, 48, context)),
                        HeaderText(title: 'Receive Notifications'),
                        SizedBox(height: sizer(false, 21, context)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: SubText(
                                title:
                                    "We'll send you notifications and updates in real time. We promise not \nto spam you.",
                                isCenter: true)),
                        SizedBox(height: sizer(false, 54, context)),
                        ButtonBlue(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                          loading: false,
                                        )),
                              );
                            },
                            title: 'NOTIFY ME'),
                        SizedBox(height: sizer(false, 24, context)),
                        Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () => Dashboard(
                                loading: false,
                              ),
                              child: Text('Don\'t send Notifications',
                                  style: TextStyle(
                                    color: Color(0xff8E919C),
                                    fontSize: sizer(true, 16.0, context),
                                  ),
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    )))));
  }
}
