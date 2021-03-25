import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/models/patient.dart';
import 'package:thcMobile/provider/user.dart';
import '../components/menuDropdown.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ScheduleAppointmentHospital extends StatefulWidget {
  ScheduleAppointmentHospital({Key key, this.title, @required this.hospital})
      : super(key: key);
  final String title;
  final Hospital hospital;

  @override
  _ScheduleAppointmentHospitalState createState() =>
      _ScheduleAppointmentHospitalState();
}

class _ScheduleAppointmentHospitalState
    extends State<ScheduleAppointmentHospital> {
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _description = new TextEditingController();
  bool loading = false;
  String dateTime = '';
  String duration = '';
  String description = '';
  String time = '';
  String date = '';
  bool _autoValidate = false;
  CalendarController _controller;

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      date = DateFormat('yyyy-MM-dd').format(day);
    });
    print(date);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Future<Null> bookAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)
      setState(() {
        loading = true;
      });
    _formKey.currentState.save();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    Response response;
    var responseJson;
    Dio dio = new Dio();

    Map<String, dynamic> data = {
      "patient": Patient.fromJson(jsonDecode(prefs.getString("patient"))).id,
      "doctor": 1,
      "preferred_time": date + ' : ' + time,
      "estimated_duration": null.toString(),
      "description": _description.text,
      "location": "online",
      "hospital": widget.hospital.id.toString(),
    };
    print('------------------\n\n$data\n\n--------------------');
    try {
      response = await dio.post(
        url + 'session-request/',
        data: data,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            }),
      );
      Fluttertoast.showToast(msg: "Successful!");
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed!");
    }
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
                            greyHolder(date),
                          ])),
                  SizedBox(height: 29),
                  bigGreyHolder('9:00 AM', () {
                    if (mounted)
                      setState(() {
                        time = '09:00:00';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('11:00 AM', () {
                    if (mounted)
                      setState(() {
                        time = '11:00:00';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('12:00 PM', () {
                    if (mounted)
                      setState(() {
                        time = '12:00:00';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('1:00 PM', () {
                    if (mounted)
                      setState(() {
                        time = '13:00:00';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('2:00 PM', () {
                    if (mounted)
                      setState(() {
                        time = '14:00:00';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                ]),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                                onPressed: () => Navigator.pop(context),
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
                          HeaderText(title: 'Book appointment'),
                          SizedBox(height: 5),
                          Text(
                              'Schedule an appointment at ${widget.hospital.user.username} hospitals',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16.0, context))),
                          SizedBox(height: 26),
                          MenuDropdown(
                            title: time != '' ? 'Time: ' + time : 'Select time',
                            onPressed: () => displayBottomSheet(context),
                          ),
                          // MenuDropdown(title: 'Home service',
                          // onPressed: () => displayBottomSheet(context),),
                          Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: MultiInput(
                                controller: _description,
                                onChanged: (text) {
                                  description = text;
                                },
                                hintText: 'Appointment description',
                              )),
                          SizedBox(height: 14),
                          Text(
                            'Select a day',
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: sizer(true, 16.0, context),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          TableCalendar(
                            calendarController: _controller,
                            initialCalendarFormat: CalendarFormat.month,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month view',
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: CalendarStyle(
                              selectedColor: Color(0xff245DE8),
                              todayColor: Colors.deepOrange[200],
                              markersColor: Colors.green,
                              outsideDaysVisible: false,
                            ),
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                  color: Color(0xff245DE8), fontSize: 16),
                              formatButtonTextStyle: TextStyle().copyWith(
                                  color: Color(0xff245DE8), fontSize: 15.0),
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.deepOrange[400],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            onDaySelected: _onDaySelected,
                            onVisibleDaysChanged: _onVisibleDaysChanged,
                            onCalendarCreated: _onCalendarCreated,
                          ),
                          Center(
                            child: loading
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xff245DE8),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, bottom: 30),
                                    width: MediaQuery.of(context).size.width,
                                    child: ButtonBlue(
                                      title: 'SUBMIT',
                                      onPressed: bookAppointment,
                                    ),
                                  ),
                          )
                        ]),
                  )),
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
      ),
    ));
  }

  Widget bigGreyHolder(String text, Function onPressed) {
    return Material(
      color: Color(0xffDFE8FC),
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 5),
          margin: EdgeInsets.only(right: 5),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Color(0xff2254D3),
                  fontSize: sizer(true, 16.0, context)),
            ),
          ),
        ),
      ),
    );
  }
}
