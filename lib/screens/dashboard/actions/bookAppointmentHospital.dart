import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/screens/dashboard/hospitals/index.dart';

class BookAppointmentHospital extends StatefulWidget {
  BookAppointmentHospital({Key key, this.title, @required this.hospital})
      : super(key: key);
  final String title;
  final Hospital hospital;

  @override
  _BookAppointmentHospitalState createState() =>
      _BookAppointmentHospitalState();
}

class _BookAppointmentHospitalState extends State<BookAppointmentHospital> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List ids = [];
  List hospitals = [];
  bool loading = true;
  var _mgStore;
  @override
  void initState() {
    super.initState();
    this._fillData();
  }

  void _fillData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    try {
      var response = await http.get(url + "hospital/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      var jsonData = jsonDecode(response.body);
      _mgStore = jsonData;
      ids = [];
      hospitals = [];
      for (var i = 0; i < jsonData.length; i++) {
        setState(() {
          ids.add(jsonData[i]['id']);
          hospitals.add(jsonData[i]['user']['username']);
        });
      }
      print(_mgStore);
      prefs.setString('hospitals', response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Request failed!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    setState(() {
      loading = false;
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
                        SizedBox(height: sizer(false, 25, context)),
                        Text(
                          'Book a physical appointment',
                          style: TextStyle(
                            color: black,
                            fontSize: pixel24,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SubText(
                            isCenter: false,
                            title:
                                'Choose a hospital to book an appointment with'),
                        SizedBox(height: sizer(false, 30, context)),
                        SearchTextInput(hintText: 'Search'),
                        SizedBox(height: 5),
                        hospitals.length > 0
                            ? SizedBox()
                            : SizedBox(
                                height: 30,
                              ),
                        loading
                            ? CenterLoader()
                            : hospitals.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: hospitals.length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        hospitalsData(
                                            hospitals[index].toString(),
                                            Hospital.fromJson(_mgStore[index]),
                                            index))
                                : EmptyData(
                                    title: "No data found",
                                    isButton: false,
                                  )
                      ]),
                )))));
  }

  Widget hospitalsData(String names, var hospital, int id) {
    return Material(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => HospitalProfile(
                        title: '',
                        hospital: hospital,
                        index: id,
                      )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xffF3F4F8), width: 1.0))),
              child: Text(names,
                  style: TextStyle(color: Color(0xff071232), fontSize: 16)),
            )));
  }
}
