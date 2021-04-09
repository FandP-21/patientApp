import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/screens/dashboard/subscribeToPlan/oneOffPlan.dart';
import 'setupYourPlan.dart';

class SubscribeToPlan extends StatefulWidget {
  SubscribeToPlan({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SubscribeToPlanState createState() => _SubscribeToPlanState();
}

class _SubscribeToPlanState extends State<SubscribeToPlan> {
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
      backgroundColor: Color(0xff071232),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              bottom: 30,
              left: sizer(true, 15, context),
              right: sizer(true, 15, context)),
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
                children: <Widget>[
                  Text(
                    'Stay covered',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Subscribe to an emergency service package to keep you covered when you need help',
                      style: TextStyle(color: white, fontSize: pixel16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 111, 79, 0.26),
                    borderRadius: BorderRadius.circular(133),
                  ),
                  child: Center(
                      child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 111, 79, 0.26),
                            borderRadius: BorderRadius.circular(113),
                          ),
                          child: Center(
                              child: Container(
                                  width: 160,
                                  height: 160,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/notificationIcon.png',
                                          height: 37,
                                          width: 37,
                                          fit: BoxFit.contain)),
                                  decoration: BoxDecoration(
                                    color: Color(0xffFF6F4F),
                                    borderRadius: BorderRadius.circular(93),
                                  )))))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: <Widget>[
                  ButtonWhite(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SetupYourPlan()),
                        );
                      },
                      title: 'SUBSCRIBE TO/REQUEST FROM EXISTING PLAN'),
                  SizedBox(height: 10),
                  ButtonWhite(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => OneOffPlan()),
                        );
                      },
                      title: 'REQUEST AMBULANCE - ONE OFF'),
                  SizedBox(height: 10),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
