import 'package:flutter/material.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/screens/dashboard/doctorRate.dart';
import 'package:thcMobile/screens/dashboard/hospitals/scheduleAppointment.dart';

class LabDetails extends StatefulWidget {
  LabDetails({Key key, this.title, @required this.hospital}) : super(key: key);
  final String title;
  final Hospital hospital;

  @override
  _LabDetailsState createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {
  IconData _selectedIcon;
  @override
  void initState() {
    super.initState();
    print(widget.hospital.user.username);
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
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 25),
            decoration: BoxDecoration(
              color: Color(0xff071232),
            ),
            child: Column(children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.close, size: 26, color: Colors.white),
                      )),
                  Spacer(),
                  Container(
                      height: 45,
                      width: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FlatButton(
                            color: blue,
                            child: Text('Book test',
                                style: TextStyle(
                                  color: white,
                                  fontSize: pixel16,
                                  fontWeight: normal,
                                )),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ScheduleAppointmentHospital(
                                      hospital: widget.hospital, title: '')));
                            },
                          ))),
                ],
              ),
              SizedBox(height: 25),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55 / 2),
                                border: Border.all(
                                  color: inputGrey.withOpacity(0.5),
                                  width: 1,
                                  style: BorderStyle.solid,
                                )),
                            child: Center(
                                child: Image.asset(
                                    'assets/images/pharmacyIcon.png',
                                    width: 55,
                                    height: 55))),
                        SizedBox(width: 15),
                        WhiteHeaderText(title: widget.hospital.user.username),
                      ],
                    ),
                    SizedBox(width: 5),
                  ]),
            ]),
          ),
          SizedBox(height: 19),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF3F4F8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    SubText(title: 'Business hours', isCenter: false),
                    SizedBox(height: sizer(false, 15, context)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Monday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.mondayFromHour ?? 'N/A'} - ${widget.hospital.mondayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Tuesday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.tuesdayFromHour ?? 'N/A'} - ${widget.hospital.tuesdayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Wednesday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.wednesdayFromHour ?? 'N/A'} - ${widget.hospital.wednesdayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Thurday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.thursdayFromHour ?? 'N/A'} - ${widget.hospital.thursdayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Friday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.fridayFromHour ?? 'N/A'} - ${widget.hospital.fridayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Saturday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.saturdayFromHour ?? 'N/A'} - ${widget.hospital.saturdayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sunday',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        Text(
                            '${widget.hospital.sundayFromHour ?? 'N/A'} - ${widget.hospital.sundayToHour ?? 'N/A'}',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 19),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF3F4F8),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SubText(title: 'Office address', isCenter: false),
                        SizedBox(height: sizer(false, 7, context)),
                        Text(widget.hospital.officeAddress ?? 'N/A',
                            style: TextStyle(
                                color: black,
                                fontSize: sizer(true, 16.0, context))),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: inputGrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ])),
              Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: sizer(false, 12, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF3F4F8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SubText(title: 'Support number', isCenter: false),
                            SizedBox(height: sizer(false, 7, context)),
                            Text(widget.hospital.phoneNumber ?? 'N/A',
                                style: TextStyle(
                                    color: black,
                                    fontSize: sizer(true, 16.0, context))),
                          ]),
                      Container(
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(51 / 2),
                            color: Color(0xff2254D3),
                          ),
                          child:
                              Icon(Icons.call, size: 24, color: Colors.white))
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF3F4F8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        SubText(title: 'Average rating', isCenter: false),
                        SizedBox(height: sizer(false, 7, context)),
                        RatingBarIndicator(
                          rating: double.parse(widget.hospital.rating) ?? "0.0",
                          itemBuilder: (context, index) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Color.fromRGBO(255, 151, 44, 1),
                          ),
                          itemCount: 5,
                          itemSize: 23.0,
                          unratedColor: Color.fromRGBO(142, 145, 156, 0.24),
                          direction: Axis.horizontal,
                        ),
                      ]),
                      SizedBox(width: 35),
                      GestureDetector(
                        child: Container(
                            height: 45,
                            width: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Rate',
                              style: TextStyle(
                                color: white,
                                fontSize: pixel16,
                                fontWeight: normal,
                              ),
                            )),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => DoctorRate(
                                    isPharmacy: false,
                                    pharmacy: null,
                                    isHospital: true,
                                    doctor: null,
                                    hospital: widget.hospital,
                                  )),
                        ),
                      )
                    ],
                  ))
            ]),
          )
        ]))));
  }
}
