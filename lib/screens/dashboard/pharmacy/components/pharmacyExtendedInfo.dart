import 'package:flutter/material.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thcMobile/models/pharmacy.dart';
import 'package:thcMobile/screens/dashboard/doctorRate.dart';

class PharmacyExtendedInfo extends StatefulWidget {
  PharmacyExtendedInfo({Key key, this.title, @required this.pharmacy})
      : super(key: key);
  final String title;
  final Pharmacy pharmacy;

  @override
  _PharmacyExtendedInfoState createState() => _PharmacyExtendedInfoState();
}

class _PharmacyExtendedInfoState extends State<PharmacyExtendedInfo> {
  IconData _selectedIcon;
  @override
  void initState() {
    super.initState();
    print(widget.pharmacy.user.username);
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
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 48, horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color(0xff071232),
                        ),
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              BackButtonBlack(
                                onPressed: () => Navigator.pop(context),
                              ),
                              Spacer(),
                              SizedBox()
                            ],
                          ),
                          SizedBox(height: 19),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(55 / 2),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/pharmacyIcon.png',
                                          width: 55,
                                          height: 55))),
                              SizedBox(width: sizer(true, 15, context)),
                              WhiteHeaderText(
                                  title: widget.pharmacy.user.username),
                              Spacer(),
                            ],
                          ),
                        ]),
                      ),
                      SizedBox(height: 19),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 19, context)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF3F4F8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SubText(
                                    title: 'Business hours', isCenter: false),
                                SizedBox(height: sizer(false, 7, context)),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Monday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.mondayFromHour} - ${widget.pharmacy.mondayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Tuesday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.tuesdayFromHour ?? 'N/A'} - ${widget.pharmacy.tuesdayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Wednesday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.wednesdayFromHour ?? 'N/A'} - ${widget.pharmacy.wednesdayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Thurday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.thursdayFromHour ?? 'N/A'} - ${widget.pharmacy.thursdayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Friday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.fridayFromHour ?? 'N/A'} - ${widget.pharmacy.fridayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Saturday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.saturdayFromHour ?? 'N/A'} - ${widget.pharmacy.saturdayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Sunday',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                    Text(
                                        '${widget.pharmacy.sundayFromHour ?? 'N/A'} - ${widget.pharmacy.sundayToHour ?? 'N/A'}',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 19),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 19, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF3F4F8),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SubText(
                                        title: 'Office Address',
                                        isCenter: false),
                                    SizedBox(height: sizer(false, 7, context)),
                                    Text(widget.pharmacy.officeAddress ?? 'N/A',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ])),
                          SizedBox(height: 19),
                          Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 19, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF3F4F8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    SubText(
                                        title: 'Support number',
                                        isCenter: false),
                                    SizedBox(height: sizer(false, 7, context)),
                                    Text(widget.pharmacy.phoneNumber ?? 'N/A',
                                        style: TextStyle(
                                            color: Color(0xff2254D3),
                                            fontSize:
                                                sizer(true, 16.0, context))),
                                  ]),
                                  Container(
                                      width: 51,
                                      height: 51,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(51 / 2),
                                        color: Color(0xff2254D3),
                                      ),
                                      child: Icon(Icons.call,
                                          size: 24, color: Colors.white))
                                ],
                              )),
                          SizedBox(height: 19),
                          Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 19, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF3F4F8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    SubText(
                                        title: 'Average rating',
                                        isCenter: false),
                                    SizedBox(height: sizer(false, 7, context)),
                                    RatingBarIndicator(
                                      rating: double.parse(widget
                                              .pharmacy.rating
                                              .toString()) ??
                                          "0.0",
                                      itemBuilder: (context, index) => Icon(
                                        _selectedIcon ?? Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 23.0,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      direction: Axis.horizontal,
                                    ),
                                  ]),
                                  SizedBox(width: 35),
                                  Expanded(
                                      child: ButtonBlue(
                                          title: 'RATE',
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) => DoctorRate(
                                                          isHospital: false,
                                                          hospital: null,
                                                          isPharmacy: true,
                                                          doctor: null,
                                                          pharmacy:
                                                              widget.pharmacy,
                                                        )),
                                              )))
                                ],
                              ))
                        ]),
                      )
                    ])))));
  }
}
