import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/haveAPlan.dart';
import 'components/firstOptions.dart';
import 'choosePlanLab.dart';

class ChooseLab extends StatefulWidget {
  ChooseLab({@required this.id, @required this.title});
  final int id;
  final String title;

  @override
  _ChooseLabState createState() => _ChooseLabState();
}

class _ChooseLabState extends State<ChooseLab> {
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
                    ],
                  ),
                  SizedBox(height: sizer(false, 20, context)),
                  HeaderText(title: widget.title),
                  SizedBox(
                    height: 8,
                  ),
                  SubText(isCenter: false, title: 'Choose an option'),
                  SizedBox(
                      height: sizer(false,
                          MediaQuery.of(context).size.height * 0.1, context)),
                  FirstOptions(
                    onPressedA: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HaveAPlan(
                                  title: widget.title,
                                ))),
                    onPressedB: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChoosePlanLab(
                                  id: widget.id,
                                  title: widget.title,
                                ))),
                  ),
                  SizedBox(height: 30),
                ]),
          ),
        ),
      ),
    );
  }
}
