import 'package:flutter/material.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';

class RequestTestKitDetails extends StatefulWidget {
  RequestTestKitDetails({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _RequestTestKitDetailsState createState() => _RequestTestKitDetailsState();
}

class _RequestTestKitDetailsState extends State<RequestTestKitDetails> {
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
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.only(
          top: sizer(false, 50, context),
          left: sizer(true, 20, context),
          bottom: 30,
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
                SizedBox()
              ],
            ),
            SizedBox(height: 20),
            Text(widget.title,
                style: TextStyle(
                  color: black,
                  fontSize: pixel24,
                  fontWeight: bold,
                )),
            SizedBox(height: 15),
            SubText(
              title: 'Kit Details',
              isCenter: false,
            ),
            SizedBox(height: 30),
            SubText(title: 'Description', isCenter: false),
            SizedBox(height: 15),
            Text(
                'Finding it hard to lose weight or putting on weight for no reason is sometimes linked to an underactive thyroid or low levels of the hormone testosterone. If you do carry some excess weight, it’s also worth checking your liver function and diabetes risk.',
                style: TextStyle(
                    color: Color(0xff071232),
                    fontSize: sizer(true, 16.0, context))),
            SizedBox(height: 40),
            SubText(title: 'Instructions for use', isCenter: false),
            SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) =>
                    steps('Step', index, index == 4 ? false : null)),
            SizedBox(height: 30),
            SubText(title: 'Intepreting Results', isCenter: false),
            scenario('Scenario 1',
                'Finding it hard to lose weight or putting on weight for no reason is sometimes linked to an underactive thyroid or low levels of the hormone testosterone. If you do carry some excess weight, it’s also worth checking your liver function and diabetes risk.'),
            scenario('Scenario 2',
                'Finding it hard to lose weight or putting on weight for no reason is sometimes linked to an underactive thyroid or low levels of the hormone testosterone. If you do carry some excess weight, it’s also worth checking your liver function and diabetes risk.'),
            scenario('Scenario 3',
                'Finding it hard to lose weight or putting on weight for no reason is sometimes linked to an underactive thyroid or low levels of the hormone testosterone. If you do carry some excess weight, it’s also worth checking your liver function and diabetes risk.')
          ]),
    ))));
  }

  Widget scenario(String name, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(name,
            style: TextStyle(
              color: blue,
              fontSize: pixel18,
              fontWeight: normal,
            )),
        SizedBox(height: 15),
        Text(body,
            style: TextStyle(
                color: Color(0xff071232),
                fontSize: sizer(true, 16.0, context))),
      ],
    );
  }

  Widget steps(String title, int index, bool last) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
          border: Border(
              bottom: last == null
                  ? BorderSide(color: Color(0xffF3F4F8), width: 1.0)
                  : BorderSide.none)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: Color.fromRGBO(223, 232, 252, 1),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: blue,
                fontWeight: normal,
                fontSize: pixel16,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            title + ' ' + (index + 1).toString(),
            style: TextStyle(
              color: black,
              fontSize: pixel16,
              fontWeight: normal,
            ),
          ),
        ],
      ),
    );
  }
}
