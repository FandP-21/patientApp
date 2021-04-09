import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/pharmacy/lab/index.dart';

class DiagnosticTestB extends StatefulWidget {
  DiagnosticTestB({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DiagnosticTestBState createState() => _DiagnosticTestBState();
}

class _DiagnosticTestBState extends State<DiagnosticTestB> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List ids = [];
  List hospitals = [];
  bool loading = true;
  var _mgStore;

  @override
  void initState() {
    super.initState();
    _fillData();
  }

  List<PharmacyWidget> pharmacies = [
    PharmacyWidget(
        location: 'Iwaya, Yaba', title: 'Medplus Lab', amount: 'NGN 1,500'),
    PharmacyWidget(
        location: 'Iwaya, Yaba', title: 'Medplus Lab', amount: 'NGN 4,500'),
    PharmacyWidget(
        location: 'Iwaya, Yaba', title: 'Medplus Lab', amount: 'NGN 4,500'),
    PharmacyWidget(
        location: 'Iwaya, Yaba', title: 'Medplus Lab', amount: 'NGN 4,500'),
  ];

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
                      bottom: 20,
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
                          'Book a Diagnostic Test',
                          style: TextStyle(
                            color: black,
                            fontSize: pixel24,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Book a diagnostic test at a THC registered Diagnostic laboratory',
                          style: TextStyle(
                            color: inputGrey,
                            fontSize: pixel16,
                            fontWeight: normal,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'This test is available at the following places',
                          style: TextStyle(
                            color: inputGrey,
                            fontSize: pixel16,
                            fontWeight: normal,
                          ),
                        ),
                        SizedBox(height: 28),
                        loading
                            ? CenterLoader()
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return pharmacyPanel(pharmacies[index],
                                      Hospital.fromJson(_mgStore[index]));
                                })
                      ]),
                )))));
  }

  Widget pharmacyPanel(PharmacyWidget pharmacy, var hospital) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Material(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => LabInfo(
                            hospital: hospital,
                            title: pharmacy.title,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(27.5),
                          child: Image.asset('assets/images/pharmacyIcon.png',
                              width: 55, height: 55, fit: BoxFit.contain)),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          Text(pharmacy.title,
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16.0, context))),
                          Text(pharmacy.location,
                              style: TextStyle(
                                  color: Color(0xff8E919C),
                                  fontSize: sizer(true, 16.0, context))),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 14.6),
                        decoration: BoxDecoration(
                          color: Color(0xffDFE8FC),
                          borderRadius: BorderRadius.circular(14.6),
                        ),
                        child: Center(
                            child: Text(pharmacy.amount,
                                style: TextStyle(
                                    color: Color(0xff2254D3),
                                    fontSize: sizer(true, 14, context)))),
                      )
                    ],
                  ),
                ))));
  }
}

class PharmacyWidget {
  String title;
  String location;
  String amount;
  PharmacyWidget(
      {@required this.title, @required this.location, @required this.amount});
}
