import 'package:flutter/material.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/models/patientInfo.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/banksWidget.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/diagnosticsWidget.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/hmoWidget.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/hospitalWidget.dart';

class HealthPlans extends StatefulWidget {
  HealthPlans({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HealthPlansState createState() => _HealthPlansState();
}

class _HealthPlansState extends State<HealthPlans> {
  String currentTab = 'hmo';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<PatientInfo> results = [];

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
          padding: EdgeInsets.only(bottom: 0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 48, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff071232),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BackButtonBlack(
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text('Health Plans',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: sizer(true, 20, context),
                              color: Colors.white)),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff2A3450),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 11),
                        child: Image.asset(
                          'assets/images/planIcon.png',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F8),
                  ),
                  padding: EdgeInsets.only(
                    top: 20,
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      currentTab == 'hmo'
                          ? activeTab('HMO', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'hmo';
                                });
                            })
                          : inactiveTab('HMO', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'hmo';
                                });
                            }),
                      currentTab == 'hospital'
                          ? activeTab('Hospital', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'hospital';
                                });
                            })
                          : inactiveTab('Hospital', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'hospital';
                                });
                            }),
                      currentTab == 'diagnostics'
                          ? activeTab('Diagnostics', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'diagnostics';
                                });
                            })
                          : inactiveTab('Diagnostics', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'diagnostics';
                                });
                            }),
                      currentTab == 'banks'
                          ? activeTab('Banks', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'banks';
                                });
                            })
                          : inactiveTab('Banks', () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'banks';
                                });
                            }),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                currentTab == 'hmo' ? HmoWidget() : Container(),
                currentTab == 'hospital' ? HospitalWidget() : Container(),
                currentTab == 'diagnostics' ? DiagnosticsWidget() : Container(),
                currentTab == 'banks' ? EmptyBanksWidget() : Container(),
              ]),
        ),
      ),
    );
  }

  Widget activeTab(String tabName, Function onPressed) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(tabName,
                  style: TextStyle(
                      color: Color(0xff2254D3),
                      fontSize: sizer(true, 16.0, context))),
              SizedBox(height: sizer(false, 15, context)),
              Container(
                  height: 3,
                  width: tabName.length < 6
                      ? (tabName.length * 10).toDouble()
                      : (tabName.length * 6).toDouble(),
                  decoration: BoxDecoration(
                    color: Color(0xff071232),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget inactiveTab(String tabName, Function onPressed) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(tabName,
                style: TextStyle(
                    color: Color(0xff071232),
                    fontSize: sizer(true, 16.0, context))),
            SizedBox(height: sizer(false, 15, context)),
            Container(
              width: 39,
              height: 3,
              decoration: BoxDecoration(color: Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
