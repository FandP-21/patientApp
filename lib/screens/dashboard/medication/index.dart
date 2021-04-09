import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/medications.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/hmoHeader.dart';
import 'addSelfMedication.dart';
import 'package:http/http.dart' as http;
import 'medicationDetails.dart';

class Medication extends StatefulWidget {
  Medication({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<dynamic> medications = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<bool> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    if (prefs.containsKey("medication")) {
      setState(() => medications = jsonDecode(prefs.getString("medication")));
    } else {
      setState(() => loading = true);
    }
    try {
      var response = await http.get(url + "self-medication/?patient=$id",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      setState(() => medications = jsonDecode(response.body));
      print(response.body);
      await prefs.setString("medication", response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No internet connection!",
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ))));
    }

    setState(() => loading = false);
    return true;
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
                    HeaderText(title: 'Medication'),
                    SizedBox(height: 35),
                    SearchTextInput(
                      hintText: 'Search for a drug',
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 16),
                    HmoHeader(
                        onPressed: () {},
                        hmoNo: '${medications.length} treatments'),
                    SizedBox(
                      height: 15,
                    ),
                    loading
                        ? CenterLoader()
                        : medications != null && medications.length > 0
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: medications.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                    children: [
                                      drugBox(
                                          Medications.fromJson(
                                              medications[index]),
                                          medications[index]['drug_sets']),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                })
                            : EmptyData(
                                title: 'You have no prescription results',
                                isButton: false),
                    SizedBox(height: 20),
                    medicationButton(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget drugBox(Medications drugs, List<dynamic> prescription) {
    return Material(
      color: Color(0xfff3f4f8),
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MedicationDetails(
                title: drugs.name,
                prescription: prescription,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                drugs.name,
                style: TextStyle(
                  color: Color(0xff071232),
                  fontSize: sizer(true, 20, context),
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 14.6),
                decoration: BoxDecoration(
                  color: Color(0xffDFE8FC),
                  borderRadius: BorderRadius.circular(14.6),
                ),
                child: Center(
                  child: Text(
                    '${drugs.drugSets.length} drugs',
                    style: TextStyle(
                      color: Color(0xff2254D3),
                      fontSize: sizer(true, 14, context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget medicationButton() {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        // side: BorderSide(color: Colors.red)
      ),
      color: Color(0xffF3F4F8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  AddSelfMedication(title: '', updateState: getData),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          // margin: EdgeInsets.only(bottom: sizer(false,19,context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 24,
                  height: 24,
                  color: Color(0xff2254D3),
                  child: Icon(Icons.add, color: Colors.white, size: 19),
                ),
              ),
              SizedBox(width: 7.5),
              Text(
                'Add self medication',
                style: TextStyle(
                  color: Color(0xff2254D3),
                  fontSize: sizer(true, 16.0, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
