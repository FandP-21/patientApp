import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'components/menuDropdown.dart';

class RequestRefill extends StatefulWidget {
  RequestRefill({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestRefillState createState() => _RequestRefillState();
}

class _RequestRefillState extends State<RequestRefill> {
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
                              BackButtonWhite(
                                onPressed: () {},
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 11),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF3F4F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/refill.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.contain))),
                            ],
                          ),
                          SizedBox(height: sizer(false, 15, context)),
                          HeaderText(title: 'Request refill'),
                          SizedBox(height: 5),
                          Text('Fill in a prescription refill form',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16.0, context))),
                          SizedBox(height: 26),
                          MenuDropdown(title: 'Alprazolam'),
                          MenuDropdown(title: 'Select refill type'),
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
                              child: ButtonBlue(
                                title: 'SUBMIT',
                                onPressed: () {},
                              ))))
                ]))));
  }
}
