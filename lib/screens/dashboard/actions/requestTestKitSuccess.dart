import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class RequestTestKitSuccess extends StatefulWidget {
  RequestTestKitSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestTestKitSuccessState createState() => _RequestTestKitSuccessState();
}

class _RequestTestKitSuccessState extends State<RequestTestKitSuccess> {
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
            child: Center(
                child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        vertical(15, true, context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: Color(0xfff4f4f8),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Image.asset(
                    'assets/images/moneyIcon.png',
                    fit: BoxFit.fitWidth,
                  )))
            ]),
            SizedBox(height: 26),
            Text(
              'Your payment was\nsuccessful, your test kit will\narrive in 5 days',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xff071232),
                  fontSize: sizer(true, 16.0, context)),
              textAlign: TextAlign.center,
            )
          ],
        ),
        vertical(25, true, context),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ButtonBlue(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Dashboard(
                            loading: false,
                          )));
                },
                title: 'DONE')),
      ],
    ))));
  }
}
