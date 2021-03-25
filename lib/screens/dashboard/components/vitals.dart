import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/buttonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/vitals.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/screens/dashboard/components/vitalsPills.dart';
import 'vitalsUpdate.dart';

class Vitals extends StatefulWidget {
  Vitals({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> {
  String bmi;
  String bp;
  String weight;
  String height;
  String bloodOxygen;
  String pulse;
  String temperature;
  List<PatientVital> vitals;
  List _historyData = [];
  var patientVitals;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  Duration twoSeconds = new Duration();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      this._offlineData();
    }
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("vitals")) {
      setState(() {
        patientVitals = jsonDecode(prefs.getString("vitals"));
        bmi = patientVitals['bmi'];
        bp = patientVitals['bp'];
        weight = patientVitals['weight'];
        height = patientVitals['height'];
        bloodOxygen = patientVitals['blood_oxygen'];
        pulse = patientVitals['pulse'];
        temperature = patientVitals['temperature'];
      });
    } else {
      setState(() {
        loading = true;
      });
    }
    this.fetchVitals();
  }

  void _refreshState() {
    Future.delayed(twoSeconds, () => fetchVitals());
  }

  Future<dynamic> fetchVitals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    var responseJson;

    try {
      var response = await http.get(url + "patient-list/" + id + '/', headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      responseJson = jsonDecode(response.body);
      setState(() {
        loading = false;
        bmi = responseJson['bmi'];
        bp = responseJson['bp'];
        weight = responseJson['weight'];
        height = responseJson['height'];
        bloodOxygen = responseJson['blood_oxygen'];
        pulse = responseJson['pulse'];
        temperature = responseJson['temperature'];
      });
      prefs.setString('vitals', response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    }
    return this._setHistory();
  }

  void _setHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("vitalsHistoryData"))
      prefs.setString("vitalsHistoryData", jsonEncode(_historyData));
    else
      setState(() {
        _historyData = jsonDecode(prefs.getString("vitalsHistoryData"));
      });
    print(
        "\n\n\n\n${jsonDecode(prefs.getString("vitalsHistoryData"))}\n\n\n\n\n");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: sizer(true, 20, context), right: sizer(true, 20, context)),
          child: !loading
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(bottom: sizer(false, 16, context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            threeDataVitalBox('BP', bp, 'mm/Hg', 'good',
                                width(47, true, context)),
                            threeDataVitalBox(
                                'Weight',
                                weight,
                                'Kg',
                                '',
                                width(39, true, context),
                                Color.fromRGBO(34, 84, 211, 1)),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              bottom: sizer(false, 16, context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              threeDataVitalBox(
                                  'BMI',
                                  (int.parse(weight ?? "1") /
                                          ((int.parse(height ?? "1") / 100) *
                                              (int.parse(height ?? "1") / 100)))
                                      .toStringAsFixed(2),
                                  '',
                                  'underweight',
                                  width(56, true, context),
                                  Color.fromRGBO(255, 111, 79, 1)),
                              SizedBox(width: 16.0),
                              threeDataVitalBoxLinear('Height', height, 'cm',
                                  '', Color.fromRGBO(34, 84, 211, 1)),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: sizer(false, 16, context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            threeDataVitalBox('BloodOxygen', bloodOxygen, '%',
                                'good', width(56, true, context)),
                            SizedBox(width: 16.0),
                            threeDataVitalBoxLinear('Pulse', pulse, 'bpm', ''),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: sizer(false, 16, context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            threeDataVitalBox('Temperature', temperature,
                                'DegC', 'good', width(56, true, context)),
                            SizedBox(width: 16.0),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => VitalsUpdate(
                                        bmi: bmi,
                                        height: height,
                                        weight: weight,
                                        temperature: temperature,
                                        bloodOxygen: bloodOxygen,
                                        pulse: pulse,
                                        updateState: _refreshState,
                                        bp: bp),
                                  ),
                                );
                              },
                              child: Container(
                                height: 95,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff2254D3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'UPDATE\nMANUALLY',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 1.5,
                                      fontSize: sizer(true, 16.0, context)),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      _historyData.length != 0
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF3F4F8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "BP",
                                            style: TextStyle(
                                                color: Color(0xff828A95),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Pulse",
                                            style: TextStyle(
                                                color: Color(0xff828A95),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "SpO2",
                                            style: TextStyle(
                                                color: Color(0xff828A95),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(
                                              _historyData.length,
                                              (index) => VitalsPills(
                                                    date: _historyData[
                                                        (_historyData.length -
                                                                1) -
                                                            index]['date'],
                                                    time: _historyData[
                                                        (_historyData.length -
                                                                1) -
                                                            index]['time'],
                                                    bp: _historyData[
                                                        (_historyData.length -
                                                                1) -
                                                            index]['bp'],
                                                    index: index,
                                                    pulse: _historyData[
                                                        (_historyData.length -
                                                                1) -
                                                            index]['pulse'],
                                                    spo2: _historyData[
                                                            (_historyData
                                                                        .length -
                                                                    1) -
                                                                index]
                                                        ['bloodOxygen'],
                                                  )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: sizer(false, 21, context),
                      ),
                      ButtonBlack(
                          title: 'UPDATE FROM SMARTWATCH', onPressed: () {})
                    ])
              : CenterLoader(),
        ),
      ),
    );
  }

  Widget threeDataVitalBox(
      String title, String value, String unit, String quality, double width,
      [Color color]) {
    return Container(
      width: width,
      height: 95,
      padding: EdgeInsets.symmetric(
          horizontal: sizer(true, 14, context), vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: black,
                    fontSize: pixel16,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.clip,
                softWrap: true,
              ),
              SizedBox(height: 5),
              Text(
                unit,
                style: TextStyle(
                    color: Color(0xff8E919C),
                    fontSize: pixel16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                value != null && value != '' ? value.toString() : 'N/A',
                style: TextStyle(
                    color: color ?? Color(0xff22D389),
                    fontSize: pixel36,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              quality != null && quality != ''
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffDFE8FC),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        quality,
                        style: TextStyle(
                          color: Color(0xff2254D3),
                          fontSize: sizer(true, 14, context),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget threeDataVitalBoxLinear(
      String title, String value, String unit, String quality,
      [Color color]) {
    return Expanded(
        child: Container(
      height: 95,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: sizer(true, 14, context), vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: black,
                fontSize: pixel16,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value != null && value != '' ? value.toString() : 'N/A',
            style: TextStyle(
                color: color ?? Color(0xff22D389),
                fontSize: pixel36,
                height: 1.2,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            unit,
            style: TextStyle(
                color: Color(0xff8E919C),
                fontSize: pixel16,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ));
  }
}
