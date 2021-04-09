import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:http/http.dart' as http;
import 'diagnosticTestB.dart';

class DiagnosticTest extends StatefulWidget {
  DiagnosticTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DiagnosticTestState createState() => _DiagnosticTestState();
}

class _DiagnosticTestState extends State<DiagnosticTest> {
  List<dynamic> testcollections = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _offlineData();
  }

  Future _offlineData() {}

  Future<Null> diagnosticTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    var response = await http.get(url + '/lab-test-names/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => testcollections = jsonDecode(response.body));
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
                    right: sizer(true, 20, context),
                  ),
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
                        Text('Choose a test type',
                            style: TextStyle(
                                color: Color(0xff245DE8),
                                fontSize: sizer(true, 16.0, context))),
                        SizedBox(height: 10),
                        SearchTextInput(
                          hintText: 'Search',
                          onChanged: (text) {},
                        ),
                        SizedBox(height: 15),
                        loading
                            ? CenterLoader()
                            : testcollections.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    itemCount: testcollections.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            CheckListTile(
                                                last: testcollections.length ==
                                                        index + 1
                                                    ? true
                                                    : false,
                                                title: testcollections[index]
                                                    ['name'],
                                                iconPresent: false))
                                : EmptyData(
                                    title: 'No diagnostics test at the moment'),
                        SizedBox(height: 54),
                        ButtonBlue(
                          title: 'NEXT',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DiagnosticTestB(title: '')));
                          },
                        ),
                        SizedBox(height: 30),
                      ]),
                )))));
  }
}

class CheckListTile extends StatefulWidget {
  CheckListTile({@required this.title, this.last, this.iconPresent});
  final String title;
  final bool last, iconPresent;

  @override
  _CheckListTileState createState() => _CheckListTileState();
}

class _CheckListTileState extends State<CheckListTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
        decoration: BoxDecoration(
            border: Border(
                bottom: widget.last == null
                    ? BorderSide(color: Color(0xffF3F4F8), width: 1.0)
                    : BorderSide.none)),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (value == false)
                      setState(() => value = true);
                    else
                      setState(() => value = false);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: value ? blue : Color.fromRGBO(223, 232, 252, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Checkbox(
                      onChanged: (val) => {},
                      value: value,
                      activeColor: blue,
                      checkColor: Colors.white,
                    ),
                  )),
              SizedBox(width: sizer(true, 17, context)),
              Text(widget.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              SizedBox(width: 82.8),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info_outline,
                      color: Colors.transparent,
                      size: sizer(true, 22, context))),
            ]));
  }
}
