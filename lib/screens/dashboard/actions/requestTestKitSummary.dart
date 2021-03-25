import 'package:flutter/material.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'requestTestKitSuccess.dart';

class RequestTestKitSummary extends StatefulWidget {
  RequestTestKitSummary({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _RequestTestKitSummaryState createState() => _RequestTestKitSummaryState();
}

class _RequestTestKitSummaryState extends State<RequestTestKitSummary> {
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
                child: new SingleChildScrollView(
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
                          ],
                        ),
                        SizedBox(height: sizer(false, 25, context)),
                        Text(
                          'Request Summary',
                          style: TextStyle(
                              color: black,
                              fontSize: pixel24,
                              fontWeight: bold),
                        ),
                        SizedBox(height: 70),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SubText(
                                    title: 'Test type',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SubText(
                                    title: 'Price',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'NGN 2,500',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(height: 55),
                        SubText(
                          title: 'Delivery Details',
                          isCenter: false,
                        ),
                        SizedBox(height: sizer(false, 12, context)),
                        AuthTextInput(
                          hintText: 'Enter Address',
                        ),
                        SizedBox(height: 15),
                        MultiInput(
                            hintText: 'Any extra notes?',
                            minLines: 5,
                            maxLines: 5),
                        vertical(10, true, context),
                        ButtonBlue(
                          title: 'ORDER TEST KIT',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    RequestTestKitSuccess(title: '')));
                          },
                        )
                      ]),
                )))));
  }
}
