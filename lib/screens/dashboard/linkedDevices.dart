import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';

class LinkedDevices extends StatefulWidget {
  LinkedDevices({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LinkedDevicesState createState() => _LinkedDevicesState();
}

class _LinkedDevicesState extends State<LinkedDevices> {
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
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Linked devices'),
                        SizedBox(height: sizer(false, 38, context)),
                        phoneBox('IPHONE XR'),
                        phoneBox('SAMSUNG S8'),
                        phoneBox('SAMSUNG S8'),
                        phoneBox('SAMSUNG S8')
                      ]),
                )))));
  }

  Widget phoneBox(String title) {
    return Container(
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
              Image.asset(
                'assets/images/deviceIcon.png',
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 18.5,
              ),
              Text(title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: Color(0xff436dda),
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xfff4e3e3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.delete,
                            size: 16,
                            color: Color(0xffFF6F4F),
                          ))))
            ]));
  }
}
