import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import '../../components/menuDropdown.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../../appointmentSuccess.dart';

class BookLabTest extends StatefulWidget {
  BookLabTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BookLabTestState createState() => _BookLabTestState();
}

class _BookLabTestState extends State<BookLabTest> {
  @override
  void initState() {
    super.initState();
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.89,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
                top: 50,
                bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  HeaderText(title: 'Select a time'),
                  SizedBox(height: 11),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            greyHolder('June 17, 2020'),
                          ])),
                  SizedBox(height: 29),
                  bigGreyHolder('9:00 AM'),
                  SizedBox(height: 11),
                  bigGreyHolder('11:00 AM'),
                  SizedBox(height: 11),
                  bigGreyHolder('12:00 PM'),
                  SizedBox(height: 11),
                  bigGreyHolder('1:00 PM'),
                  SizedBox(height: 11),
                  bigGreyHolder('2:00 PM'),
                  SizedBox(height: 11),
                ]),
          );
        });
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
                                          'assets/images/appointmentBlue.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.contain))),
                            ],
                          ), //
                          SizedBox(height: sizer(false, 15, context)),
                          HeaderText(title: 'Book test appointment'),
                          SizedBox(height: 5),
                          Text('Pick a date and time for your appointment',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16.0, context))),
                          SizedBox(height: 26),
                          MenuDropdown(
                            title: 'Select time',
                            onPressed: () => displayBottomSheet(context),
                          ),
                          MenuDropdown(title: 'Choose appointment type'),

                          MenuDropdown(title: 'Choose appointment type'),
                          MultiInput(
                            onChanged: (text) {},
                            hintText:
                                'Test description is automatically populated here',
                          ),
                          SizedBox(height: 14),
                          Text('Select a day',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16.0, context),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 5),
                          new Calendar(
                            onSelectedRangeChange: (range) => print(
                                "Range is ${range.item1}, ${range.item2}"),
                            isExpandable: true,
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
                              child: ButtonBlue(
                                title: 'SUBMIT',
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => AppointmentSuccess()),
                                  );
                                },
                              ))))
                ]))));
  }

  Widget greyHolder(String text) {
    return (Container(
        decoration: BoxDecoration(
          color: Color(0xffDFE8FC),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
        margin: EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color(0xff2254D3), fontSize: sizer(true, 16.0, context)),
          ),
        )));
  }

  Widget bigGreyHolder(String text) {
    return (Container(
        decoration: BoxDecoration(
          color: Color(0xffDFE8FC),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 5),
        margin: EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color(0xff2254D3), fontSize: sizer(true, 16.0, context)),
          ),
        )));
  }
}
