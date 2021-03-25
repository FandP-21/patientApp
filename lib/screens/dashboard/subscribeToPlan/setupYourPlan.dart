import 'package:flutter/material.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'requestAmbulance.dart';

class SetupYourPlan extends StatefulWidget {
  SetupYourPlan({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetupYourPlanState createState() => _SetupYourPlanState();
}

class _SetupYourPlanState extends State<SetupYourPlan> {
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
                child: Stack(children: <Widget>[
                  new SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 50, context),
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              BackButtonBlack(
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          SizedBox(height: sizer(false, 25, context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  WhiteHeaderText(title: 'Setup your plan'),
                                  SizedBox(height: 5),
                                  Text('Choose your preferred hospital',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              sizer(true, 16.0, context))),
                                ],
                              ),
                              Material(
                                color: Color(0xffff6f4f),
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(),
                                  child: Center(
                                    child: Image.asset(
                                        'assets/images/notificationIcon.png',
                                        width: 22,
                                        height: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 26),
                          DropdownWidget(
                            title: 'Select hospital',
                            store: ['IFEDOC', 'ELONA', 'ELONAA'],
                            altColor: Color(0xff0C1941),
                            altDropdownColor: Color(0xff0C1941),
                            altTextColor: white,
                            altArrowColor: white,
                          ),
                          SizedBox(height: sizer(false, 10, context)),
                          DropdownWidget(
                            title: 'Select subscription package',
                            store: ['N/A', 'N/A', 'N/A'],
                            altColor: Color(0xff0C1941),
                            altDropdownColor: Color(0xff0C1941),
                            altTextColor: white,
                            altArrowColor: white,
                          ),
                        ]),
                  )),
                  Positioned(
                      bottom: 30,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  left: sizer(true, 20, context),
                                  right: sizer(true, 20, context)),
                              child: ButtonWhite(
                                title: 'PAY NG 4,500/month',
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => RequestAmbulance()),
                                  );
                                },
                              ))))
                ]))));
  }
}
