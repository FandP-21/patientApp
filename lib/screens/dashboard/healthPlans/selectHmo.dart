import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/hmo.dart';
import 'package:thcMobile/provider/user.dart';
import 'chooseHmo.dart';

class SelectHmo extends StatefulWidget {
  SelectHmo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectHmoState createState() => _SelectHmoState();
}

class _SelectHmoState extends State<SelectHmo> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<dynamic> hmos = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  Future<dynamic> getData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("allHmos")) {
      setState(() => hmos = jsonDecode(prefs.getString("allHmos")));
    } else {
      setState(() => loading = true);
    }

    var response = await http.get(url + "health-mgt-org/", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }).catchError((e) {
      setState(() => loading = false);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
      } else {
        message = e.response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
    });

    setState(() => hmos = jsonDecode(response.body));
    prefs.setString("allHmos", response.body);
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                SizedBox(height: sizer(false, 20, context)),
                HeaderText(title: 'Register with a HMO'),
                SizedBox(
                  height: 8,
                ),
                SubText(
                    isCenter: false,
                    title: 'Choose your preferred healthcare provider'),
                SizedBox(height: sizer(false, 15, context)),
                SearchTextInput(
                  hintText: "Search",
                ),
                loading
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 80),
                        child: CenterLoader())
                    : hmos != null && hmos.length > 0
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: hmos.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Column(
                                children: [
                                  hmo(AllHmo.fromJson(hmos[index])),
                                  SizedBox(height: 10),
                                ],
                              );
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 80),
                            child: EmptyData(
                              title: 'No available hmo  ',
                              isButton: false,
                            )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hmo(AllHmo hmo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChooseHmo(id: hmo.id, title: hmo.user.username),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0),
            ),
          ),
          child: Text(
            hmo.user.username,
            style: TextStyle(color: Color(0xff071232), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
