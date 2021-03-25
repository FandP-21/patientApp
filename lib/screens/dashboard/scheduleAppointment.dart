import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'components/menuDropdown.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'appointmentSuccess.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ScheduleAppointment extends StatefulWidget {
  ScheduleAppointment(
      {Key key,
      this.title,
      @required this.doctorId,
      @required this.doctorName,
      @required isSession,
      @required this.hospitalId})
      : super(key: key);
  final String title;
  final int doctorId;
  final int hospitalId;
  final bool isSession = false;
  final String doctorName;

  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  String dateTime = '';
  String duration = '';
  String description = '';
  String time = '';
  String date = '';
  bool _autoValidate = false;
  CalendarController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  void saveData() {
    if (_formKey.currentState.validate()) {
      if (date == '') {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Date is required',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      } else if (time == '') {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Time is required',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      } else if (duration == '') {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Duration is required',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      } else {
        print(date + ':' + time);
        if (mounted)
          setState(() {
            dateTime = date + ':' + time;
          });
        _formKey.currentState.save();
        postData();
      }
    } else {
//    If all data are not valid then start auto validation.
      if (mounted)
        setState(() {
          _autoValidate = true;
        });
    }
  }

  Future postData() async {
    _formKey.currentState.save();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    // String id = (prefs.getString('main_id') ?? '');
    if (mounted)
      setState(() {
        loading = true;
      });
    var responseJson;
    Response response;
    Dio dio = new Dio();
    Map<String, dynamic> data = {
      "patient": 1,
      "doctor": widget.doctorId,
      "preferred_time": dateTime,
      "estimated_duration": duration,
      "description": description,
      "location": "on-site",
      "hospital": widget.hospitalId,
    };
    // print('------------------\n\n$data\n\n--------------------');
    response = await dio
        .post(
      url +
          '${widget.isSession ? "session-request/" : "schedule-appointment/"}',
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
    )
        .catchError((e) {
      if (mounted)
        setState(() {
          loading = false;
        });
      print(e.response.data);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
      } else {
        message = e.response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    });
    if (mounted)
      setState(() {
        loading = false;
      });
    responseJson = response.data;
    if (response.statusCode != 201) {
      var message = '';
      if (response.data['detail'] != null) {
        message = response.data['detail'];
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      return Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AppointmentSuccess()),
      );
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
                            greyHolder(duration),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 1.5, horizontal: 5),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffBA62FE),
                            //       borderRadius: BorderRadius.circular(5)),
                            //   child: Center(
                            //     child: Text('Video consultation',
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: sizer(true,16.0,context))),
                            //   ),
                            // )
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

  void displaySecondBottomSheet(BuildContext context) {
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
                  HeaderText(title: 'Select duration'),
                  SizedBox(height: 11),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            greyHolder(date),
                            greyHolder(time),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 1.5, horizontal: 5),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffBA62FE),
                            //       borderRadius: BorderRadius.circular(5)),
                            //   child: Center(
                            //     child: Text('Video consultation',
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: sizer(true,16.0,context))),
                            //   ),
                            // )
                          ])),
                  SizedBox(height: 29),
                  bigGreyHolder('30 min', () {
                    if (mounted)
                      setState(() {
                        duration = '30 min';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('1 hour', () {
                    if (mounted)
                      setState(() {
                        duration = '1 hour';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('2 hours', () {
                    if (mounted)
                      setState(() {
                        duration = '2 hours';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('3 hours', () {
                    if (mounted)
                      setState(() {
                        duration = '3 hours';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                  bigGreyHolder('4 hours', () {
                    if (mounted)
                      setState(() {
                        duration = '4 hours';
                      });
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 11),
                ]),
          );
        });
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() => date = DateFormat('yyyy-MM-dd').format(day));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingOverlay(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
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
                      HeaderText(title: 'Schedule appointment'),
                      SizedBox(height: 5),
                      Text(
                        'Schedule an appointment with Dr ' + widget.doctorName,
                        style: TextStyle(
                          color: Color(0xff071232),
                          fontSize: sizer(true, 16.0, context),
                        ),
                      ),
                      SizedBox(height: 26),
                      MenuDropdown(
                        title: time != '' ? 'Time: ' + time : 'Select time',
                        onPressed: () => displayBottomSheet(context),
                      ),
                      MenuDropdown(
                        title: duration != ''
                            ? 'Duration: ' + duration
                            : 'Select duration',
                        onPressed: () => displaySecondBottomSheet(context),
                      ),
                      Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: MultiInput(
                            onChanged: (text) {
                              description = text;
                            },
                            hintText: 'Appointment description',
                          )),
                      SizedBox(height: 20),
                      Text('Select a day',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 16.0, context),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      TableCalendar(
                        calendarController: _controller,
                        // events: _events,
                        // holidays: _holidays,
                        initialCalendarFormat: CalendarFormat.month,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month view',
                          // CalendarFormat.week: 'Week view',
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          selectedColor: Color(0xff245DE8),
                          todayColor: Colors.deepOrange[200],
                          markersColor: Colors.green,
                          outsideDaysVisible: false,
                        ),
                        headerStyle: HeaderStyle(
                          titleTextStyle:
                              TextStyle(color: Color(0xff245DE8), fontSize: 16),
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
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 30),
                          width: MediaQuery.of(context).size.width,
                          child: ButtonBlue(
                            title: 'SUBMIT',
                            onPressed: () {
                              saveData();
                            },
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
        isLoading: loading,
      ),
    );
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
