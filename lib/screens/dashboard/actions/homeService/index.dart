import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/models/patient.dart';
import 'package:thcMobile/provider/user.dart';
import '../../components/menuDropdown.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:http/http.dart' as http;

class HomeServiceRequest extends StatefulWidget {
  HomeServiceRequest({Key key, this.title, @required this.doctor})
      : super(key: key);
  final String title;
  final Doctor doctor;

  @override
  _HomeServiceRequestState createState() => _HomeServiceRequestState();
}

class _HomeServiceRequestState extends State<HomeServiceRequest> {
  String dateTime = '';
  String duration = '';
  String description = '';
  String time = '';
  String date = '';
  String _title = 'Home service';
  bool loading = true;
  CalendarController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      date = DateFormat('yyyy-MM-dd').format(day);
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
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

  Future<Null> requestHomeService() async {
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var patientId = jsonDecode(prefs.getString("patient"));

    Map<String, dynamic> data = {
      "patient": Patient.fromJson(patientId).id,
      "doctor": widget.doctor.id,
      "date_needed": "",
      "notes": "",
    };

    var response = http.post(
      url + "home-service-request/",
      headers: {"Connection": 'keep-alive', "Authorization": "Bearer " + token},
      body: data,
    );
    Fluttertoast.showToast(msg: "Successful");
    setState(() {
      loading = false;
    });
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
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
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      ), //
                      SizedBox(
                        height: sizer(false, 15, context),
                      ),
                      HeaderText(title: 'Home service request'),
                      SizedBox(height: 5),
                      Text(
                        'Request a home visit from your consultant',
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
                      // MenuDropdown(title: 'Home service',
                      // onPressed: () => displayBottomSheet(context),),

                      Container(
                        margin:
                            EdgeInsets.only(bottom: sizer(false, 16, context)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F4F8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<String>(
                            hint: Text(
                              _title,
                              style: TextStyle(
                                  color: Color(0xff2254D3),
                                  fontFamily: 'SofiaPro',
                                  fontSize: sizer(true, 16.0, context)),
                            ),
                            items: ['Home service'].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(() {
                                    _title = value;
                                    // hospitalID =
                                    //     ids[hospitals.indexOf(value)];
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {});
                            },
                            isExpanded: true,
                            style: TextStyle(
                                color: Color(0xff828A95),
                                fontFamily: 'SofiaPro',
                                fontSize: 14),
                            underline: SizedBox(),
                            dropdownColor: Colors.white,
                            iconDisabledColor: Color(0xff2254D3),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xff2254D3),
                            ),
                          ),
                        ),
                      ),
                      MultiInput(
                        onChanged: (text) {},
                        hintText: 'Appointment request notes',
                      ),
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
                            onPressed: () => requestHomeService,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
