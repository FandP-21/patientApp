import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/auth/components/setNotifications.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';

class RegisterSuccess extends StatefulWidget {
  RegisterSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterSuccessState createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
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
                            padding:
                                EdgeInsets.only(top: 57, left: 60, right: 60),
                            child: Text(
                              "You've successfully created a THC account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: pixel16,
                                height: 1.5,
                              ),
                            ))),
                    ButtonBlue(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => SetNotifications()),
                          );
                        },
                        title: 'CONTINUE'),
                  ],
                ))));
  }
}
