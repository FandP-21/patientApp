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
import 'package:thcMobile/screens/dashboard/healthPlans/selectHmo.dart';

class HmoWidget extends StatefulWidget {
  @override
  _HmoWidgetState createState() => _HmoWidgetState();
}

@override
class _HmoWidgetState extends State<HmoWidget> {
  @override
  void initState() {
    super.initState();
    fetchHMO();
  }

  List _hmoData = [];
  bool loading = false;

  Future<dynamic> fetchHMO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Response response;
    Dio dio = Dio();
    if (prefs.containsKey("hmoData")) {
      setState(() {
        _hmoData = jsonDecode(prefs.getString("hmoData"));
      });
    } else {
      setState(() => loading = true);
    }
    response = await dio.get(
      url + "hmo-subscription/$id/",
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
    print(response.data);
    setState(() => _hmoData = response.data);
    setState(() => loading = false);
    prefs.setString("hmoData", jsonEncode(response.data));
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
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          loading ? SizedBox(height: 80) : SizedBox(),
          loading
              ? CenterLoader()
              : _hmoData.length > 0
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
                              "${_hmoData.length} HMO plans",
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
          _hmoData.length > 0
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 70),
                      itemCount: _hmoData.length,
                      itemBuilder: (BuildContext context, int index) => HmoBox(
                          name: _hmoData[index]['hmo_plan']['name'].toString(),
                          amount: _hmoData[index]['duration'] == '6'
                              ? _hmoData[index]['hmo_plan']
                                          ['six_months_price'] !=
                                      null
                                  ? (int.parse(_hmoData[index]['hmo_plan']
                                              ['six_months_price']) /
                                          6)
                                      .ceil()
                                      .toString()
                                  : _hmoData[index]['hmo_plan']
                                      ['six_months_price']
                              : _hmoData[index]['hmo_plan']
                                          ['one_year_price'] !=
                                      null
                                  ? (int.parse(_hmoData[index]['hmo_plan']
                                              ['one_year_price']) /
                                          12)
                                      .ceil()
                                      .toString()
                                  : _hmoData[index]['hmo_plan']
                                      ['one_year_price'],
                          type: _hmoData[index]['duration'] == '6'
                              ? 'month'
                              : 'year',
                          renewDate: predictExpiry(
                              _hmoData[index]['activate_date'],
                              _hmoData[index]['duration']))))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Image.asset(
                      'assets/images/emptyHmo.png',
                      width: 100,
                      height: 80,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'You are not afilliated \nwith any HMOs',
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
          ? Positioned(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: sizer(true, 15, context),
                    right: sizer(true, 15, context)),
                child: ButtonBlue(
                  title:
                      'SETUP ${_hmoData.length == 0 ? 'A' : 'NEW'} HEALTH PLAN',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SelectHmo(),
                      ),
                    );
                  },
                ),
              ))
          : SizedBox(),
    ]));
  }
}
