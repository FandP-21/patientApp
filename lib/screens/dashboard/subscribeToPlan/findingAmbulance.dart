import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'dart:async';
import 'package:thcMobile/screens/dashboard/subscribeToPlan/ambulanceArrived.dart';

class FindingAmbulance extends StatefulWidget {
  FindingAmbulance({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FindingAmbulanceState createState() => _FindingAmbulanceState();
}

class _FindingAmbulanceState extends State<FindingAmbulance> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AmbulanceArrived(),
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071232),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              height: height(100, true, context),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      left: -120,
                      right: -120,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 111, 79, 0.26),
                        ),
                      )),
                  Positioned.fill(
                      left: -60,
                      right: -60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 111, 79, 0.26),
                        ),
                      )),
                  Positioned.fill(
                      left: -1,
                      right: -1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 111, 79, 0.26),
                        ),
                      )),
                  Positioned.fill(
                      left: 120,
                      right: 120,
                      child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF6F4F),
                        ),
                        child: Image.asset('assets/images/notificationIcon.png',
                            height: 60, width: 60, fit: BoxFit.contain),
                      ))
                ],
              ),
            ),
            Container(
              height: height(100, true, context),
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 20,
                bottom: 30,
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.close,
                              color: white,
                              size: 20,
                            ),
                          ),
                        )
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      vertical(10, true, context),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Requesting \nemergency services',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  vertical(266, false),
                  ButtonWhite(
                      onPressed: () => Navigator.pop(context),
                      title: 'CANCEL REQUEST'),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
