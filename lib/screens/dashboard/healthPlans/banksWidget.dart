import 'package:flutter/material.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/models/patientInfo.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/hmoBox.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/hmoHeader.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/selectHmo.dart';

class BanksWidget extends StatelessWidget {
  BanksWidget({this.info, this.hospitalNo});
  final int hospitalNo;
  final Hospitals info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: sizer(true, 20, context),
          right: sizer(true, 20, context),
          bottom: 30),
      child: Column(
        children: <Widget>[
          HmoHeader(onPressed: () {}, hmoNo: '$hospitalNo hospital registered'),
          SizedBox(height: 20),
          HmoBox(
              type: "month",
              amount: '8 months',
              name: '${info.user.username}',
              renewDate: '${info.officeAddress}'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
              child: ButtonBlue(
                title: 'SETUP A HEALTH PLAN',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SelectHmo(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyBanksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Image.asset(
              'assets/images/emptyHmo.png',
              width: 100,
              height: 80,
            ),
            SizedBox(height: 50),
            Text(
              'You are not subscribed to any bank',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff8E919C),
                fontSize: sizer(true, 16.0, context),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 20, context),
                right: sizer(true, 20, context)),
            child: ButtonBlue(
              title: 'SETUP A HEALTH PLAN',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SelectHmo(),
                  ),
                );
              },
            ),
          ),
      ],
    ));
  }
}
