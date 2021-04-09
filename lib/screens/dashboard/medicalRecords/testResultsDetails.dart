import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/moreButton.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/authSelectInput.dart';
import 'package:thcMobile/helpers/styles.dart';
import 'package:thcMobile/models/testResult.dart';

class TestResultsDetails extends StatefulWidget {
  final String title;
  final Tests testdetails;
  TestResultsDetails({Key key, this.title, @required this.testdetails})
      : super(key: key);

  @override
  _TestResultsDetailsState createState() => _TestResultsDetailsState();
}

class _TestResultsDetailsState extends State<TestResultsDetails> {
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
    print(widget.testdetails);
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
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
                            MoreButton(onPressed: () {})
                          ],
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: widget.testdetails.testName.name),
                        SizedBox(height: 35),
                        SubText(
                            title: widget.testdetails.category.name,
                            isCenter: false),
                        Text(
                            'This is a simple Leads detail page with creation form, calendar view. This is a simple Leads detail page with creation form, calendar view.',
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: sizer(true, 16.0, context))),
                        SizedBox(height: 23),
                        SubText(title: 'Select date', isCenter: false),
                        SizedBox(height: 5),
                        AuthSelectInput(
                          hintText: 'October 26, 2020',
                        ),
                        SizedBox(height: 22),
                        Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                            color: Color(0xffDFE8FC),
                          ),
                        ),
                        SizedBox(height: 19),
                        SubText(title: 'Test Results', isCenter: false),
                        testPanel('Sodium Urine Spot', '4.65', true, true),
                        testPanel('Sodium Urine Spot', '4.65', false, true),
                        testPanel('Sodium Urine Spot', '4.65', true, true),
                        testPanel('Sodium Urine Spot', '4.65', true, true),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Radiologist Remarks',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: sizer(true, 14, context))),
                              SizedBox(height: 10),
                              Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: roundedF3Box,
                                  child: Text(
                                      'Raising say express had chiefly detract demands she. Quiet led own cause three him. Front no party young abode state up. Saved he do fruit woody of to. Met defective are allowance two perceived listening consulted contained. It chicken oh colonel pressed excited suppose to shortly. ',
                                      style: TextStyle(
                                          color: Color(0xff071232),
                                          fontSize:
                                              sizer(true, 16.0, context))))
                            ]),
                        SizedBox(height: 23),
                        ButtonBlue(
                          title: 'SHARE RESULTS',
                          onPressed: () {},
                        )
                      ]),
                )))));
  }

  Widget testPanel(String title, String value, bool high, bool showValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                color: Color(0xff2254D3), fontSize: sizer(true, 14, context))),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
          decoration: BoxDecoration(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(value,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              showValue
                  ? high
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 111, 79, 0.13),
                            borderRadius: BorderRadius.circular(14.6),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                              child: Text('high',
                                  style: TextStyle(
                                      fontSize: sizer(true, 14, context),
                                      color: Color(0xffFF6F4F)))),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(34, 211, 137, 0.12),
                            borderRadius: BorderRadius.circular(14.6),
                          ),
                          child: Center(
                              child: Text('normal',
                                  style: TextStyle(
                                      fontSize: sizer(true, 14, context),
                                      color: Color(0xff22D389)))),
                        )
                  : Container()
            ],
          ),
        )
      ],
    );
  }
}
