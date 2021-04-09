import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/hmoBox.dart';
import 'package:thcMobile/screens/dashboard/medHub/components/dignosticCentre.dart';

class DiagnosticsWidget extends StatefulWidget {
  @override
  _DiagnosticsWidgetState createState() => _DiagnosticsWidgetState();
}

@override
class _DiagnosticsWidgetState extends State<DiagnosticsWidget> {
  @override
  void initState() {
    super.initState();
    fetchlabPlans();
  }

  List _labData = [];
  bool loading = false;

  Future<dynamic> fetchlabPlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("labPlansData"))
      setState(() => _labData = jsonDecode(prefs.getString('labPlansData')));
    else
      setState(() => loading = true);
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Response response;
    Dio dio = Dio();

    response = await dio.get(
      url + "lab-subscription/?patient=$id",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      ),
    );
    setState(() => _labData = response.data);
    setState(() => loading = false);
    prefs.setString("labPlansData", jsonEncode(response.data));
  }

  predictExpiry(day, timestamp) {
    DateTime date = DateTime.parse(day);
    List<dynamic> present;
    var formatter = DateFormat('yyyyMMdd');
    String i = formatter.format(date)[0] +
        formatter.format(date)[1] +
        formatter.format(date)[2] +
        formatter.format(date)[3];
    String don =
        int.parse(formatter.format(date)[4] + formatter.format(date)[5])
            .toString();
    String tire =
        int.parse(formatter.format(date)[6] + formatter.format(date)[7])
            .toString();
    present = jsonDecode('[$i, $don, $tire]');

    DateTime future;
    if (timestamp == '6')
      future = DateTime(present[0], present[1] + 6, present[2]);
    else
      future = DateTime(present[0] + 1, present[1], present[2]);

    String then = DateFormat('yyyy-MM-dd').format(future);
    return then;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(alignment: Alignment.bottomCenter, children: [
      Column(
        children: <Widget>[
          loading ? SizedBox(height: 80) : SizedBox(),
          loading
              ? CenterLoader()
              : _labData.length > 0
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_labData.length} diagnostic plans",
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 20, context)),
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Color(0xffDFE8FC),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xff2254D3),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
          loading
              ? SizedBox()
              : _labData.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 70),
                          itemCount: _labData.length,
                          itemBuilder: (BuildContext context, int index) =>
                              HmoBox(
                                  name: _labData[index]['name'].toString(),
                                  amount: _labData[index]['description'] == '6'
                                      ? _labData[index]['six_months_price'] !=
                                              null && _labData[index]['six_months_price'] !=
                                              "null"
                                          ? (int.parse(_labData[index]
                                                      ['six_months_price']) /
                                                  6).ceil()
                                              .toString()
                                          : _labData[index]['six_months_price'].toString()
                                      : _labData[index]['one_year_price'] !=
                                              null && _labData[index]['one_year_price'] !=
                                              "null"
                                          ? (int.parse(_labData[index]
                                                      ['one_year_price']) /
                                                  12).ceil()
                                              .toString()
                                          : _labData[index]['one_year_price'].toString(),
                                  type: _labData[index]['description'] == '6'
                                      ? 'month'
                                      : 'year',
                                  expired: _labData[index]['status'].toString(),
                                  renewDate: predictExpiry(
                                      _labData[index]['activate_date'],
                                      _labData[index]['description']))))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        Image.asset(
                          'assets/images/emptyHmo.png',
                          width: 100,
                          height: 80,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Text(
                          'You are not registered with any lab',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff8E919C),
                            fontSize: sizer(true, 16.0, context),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
      !loading
          ? Container(
              height: 60,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              width: double.infinity,
              child: ButtonBlue(
                title:
                    'SETUP ${_labData.length == 0 ? 'A' : 'NEW'} HEALTH PLAN',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DiagnosticCentre(),
                    ),
                  );
                },
              ))
          : SizedBox(),
    ]));
  }
}

class EmptyDiagnosticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Image.asset(
              'assets/images/emptyHmo.png',
              width: 100,
              height: 80,
            ),
            SizedBox(height: 50),
            Text(
              'You are not registered with any \ndiagnostics centre',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff8E919C),
                fontSize: sizer(true, 16.0, context),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              left: sizer(true, 20, context), right: sizer(true, 20, context)),
          child: ButtonBlue(
            title: 'SETUP A HEALTH PLAN',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DiagnosticCentre(),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
