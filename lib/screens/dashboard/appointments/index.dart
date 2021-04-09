import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import '../components/appointmentBox.dart';
import 'package:thcMobile/models/appointment.dart';
import 'package:thcMobile/provider/user.dart';

class Appointments extends StatefulWidget {
  Appointments({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  bool upcoming = true;
  bool loading = false;
  bool loadingPast = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Appointment> appointments = [];
  List<Appointment> appointmentsPast = [];
  List appointmentsData = [];
  List previousAppointmentsData = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      offlineData();
    }
  }

  void offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("upcomingAppointment") &&
        prefs.containsKey("yourSessionHistory")) {
      final String yourApp = prefs.getString('upcomingAppointment');
      final String yourPreviousSessions = prefs.getString('yourSessionHistory');
      setState(() {
        appointmentsData = jsonDecode(yourApp);
        previousAppointmentsData = jsonDecode(yourPreviousSessions);
      });
      this.getAppointmentsData();
    } else {
      setState(() {
        loading = true;
      });
      this.getAppointmentsData();
    }
  }

  void getAppointmentsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    // String id = (prefs.getString('main_id') ?? '');
    Map<String, dynamic> data = {"patient": id};

    try {
      var response = await http.post(url + "upcoming-appointment/$id/",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      var responseX = await http.post(url + "patient-session-history/",
          body: data,
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      setState(() {
        previousAppointmentsData = jsonDecode(responseX.body);
        appointmentsData = jsonDecode(response.body);
        loading = false;
      });
      print(appointmentsData);
      await prefs.setString('yourSessionHistory', responseX.body);
      await prefs.setString('upcomingAppointment', response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
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
          child: new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: sizer(false, 48, context),
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BackButtonWhite(
                        onPressed: () {},
                      ),
                      Text('Appointments',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 18, context),
                              fontWeight: FontWeight.w700)),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 11),
                        decoration: BoxDecoration(
                          color: Color(0xffF3F4F8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Image.asset(
                              'assets/images/appointmentsIcon.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Container(
                    width: 194,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          upcoming
                              ? Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(() {
                                          upcoming = true;
                                        });
                                    },
                                    child: activeTab('Upcoming'),
                                  ),
                                )
                              : Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(() {
                                          upcoming = true;
                                        });
                                    },
                                    child: inActiveTab('Upcoming'),
                                  ),
                                ),
                          !upcoming
                              ? Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(() {
                                          upcoming = false;
                                        });
                                    },
                                    child: activeTab('Previous'),
                                  ),
                                )
                              : Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(
                                          () {
                                            upcoming = false;
                                          },
                                        );
                                    },
                                    child: inActiveTab('Previous'),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  upcoming
                      ? loading
                          ? CenterLoader()
                          : appointmentsData != []
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: appointmentsData.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return new AppointmentBox(
                                        isPrevious: false,
                                        appointment: Appointment.fromJson(
                                            appointmentsData[index]),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => Appointments()),
                                          );
                                        });
                                  },
                                )
                              : EmptyData(
                                  title: 'You have no upcoming appointments',
                                  isButton: false)
                      : loadingPast
                          ? CenterLoader()
                          : previousAppointmentsData != []
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: previousAppointmentsData.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return new AppointmentBox(
                                        isPrevious: true,
                                        appointment: Appointment.fromJson(
                                            previousAppointmentsData[index]),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => Appointments()),
                                          );
                                        });
                                  },
                                )
                              : EmptyData(
                                  title:
                                      'You\'ve not made any previous appointments',
                                  isButton: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget activeTab(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff2254D3),
            fontWeight: FontWeight.w500,
            fontSize: sizer(true, 14, context),
          ),
        ),
      ),
    );
  }

  Widget inActiveTab(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(5.0),
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff8E919C),
            fontWeight: FontWeight.w500,
            fontSize: sizer(true, 14, context),
          ),
        ),
      ),
    );
  }
}
