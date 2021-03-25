import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/components/buttonBlack.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'findingAmbulance.dart';

class RequestAmbulance extends StatefulWidget {
  RequestAmbulance({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestAmbulanceState createState() => _RequestAmbulanceState();
}

class _RequestAmbulanceState extends State<RequestAmbulance> {
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
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 20, context),
                      left: 20,
                      right: 20,
                      bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BackButtonBlack(
                            onPressed: () => Navigator.pop(context),
                          ),
                          Spacer(),
                        ],
                      ),
                      vertical(5, false),
                      Container(
                          height: 50,
                          child: Stack(alignment: Alignment.center, children: <
                              Widget>[
                            Container(
                                height: 50,
                                width: width(70, true, context),
                                decoration: BoxDecoration(
                                    color: Color(0xffFF6F4F),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/images/ambulanceRed.png',
                                  fit: BoxFit.fill,
                                )),
                            Container(
                                height: 50,
                                width: width(70, true, context),
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/images/charge.png',
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.contain),
                                      SizedBox(width: 5),
                                      Text(
                                          'You have 3 requests left this month',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  sizer(true, 14, context),
                                              fontWeight: FontWeight.w500))
                                    ])),
                          ])),
                      SizedBox(height: 30),
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
                                            borderRadius:
                                                BorderRadius.circular(93),
                                          )))))),
                      SizedBox(height: 30),
                      Column(
                        children: <Widget>[
                          ButtonWhite(
                            title: 'REQUEST AMBULANCE',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => FindingAmbulance()),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          ButtonBlack(
                            title: 'RENEW SUBSCRIPTION',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
