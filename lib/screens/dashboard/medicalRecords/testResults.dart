import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/testResult.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/components/hmoHeader.dart';
import 'package:thcMobile/utils/call_utilities.dart';
import 'testResultsDetails.dart';
import 'package:http/http.dart' as http;

class TestResults extends StatefulWidget {
  TestResults({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TestResultsState createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchController = new TextEditingController();
  List<Tests> results = [];
  List<Tests> copyListList = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  Future getData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    if (mounted)
      setState(() {
        loading = true;
      });
    var responseJson;
    final response = await http.get(url + "lab-test-result/$id",
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    print(response.body);
    if (mounted)
      setState(() {
        loading = false;
      });
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body);
      for (var i = 0; i < responseJson.length; i++) {
          results.add(Tests.fromJson(responseJson[i]));
          copyListList.add(Tests.fromJson(responseJson[i]));
      }
      setState(() {
      });
    }else{
      showInSnackBar('Error',_scaffoldKey,context);
    }
    return true;
  }
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Tests> dummyListData =[];
      for (int i = 0; i < copyListList.length; i++) {
        if (copyListList[i].testName.name.toString().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(copyListList[i]);
        }
      }
      setState(() {
        results.clear();
        results.addAll(dummyListData);
      });
      print(copyListList);
      return;
    } else {
      setState(() {
        results.clear();
        results.addAll(copyListList);
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
                  HeaderText(title: 'Test Results'),
                  SizedBox(height: 15),
                  SearchTextInput(
                    hintText: 'Search for a result',
                    textController: searchController,
                    onChanged: (text) {
                      filterSearchResults(text);
                    },
                  ),
                  SizedBox(height: 10),
                  HmoHeader(
                      onPressed: () {
                      },
                      hmoNo: '${results.length} test results'),
                  SizedBox(height: 15),
                  loading
                      ? CenterLoader()
                      : results != null && results.length > 0
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Column(
                                  children: [
                                    drugBox(results[index]),
                                    SizedBox(height: 10),
                                  ],
                                );
                              })
                          : EmptyData(
                              title: 'You have no lab results',
                              isButton: false),
                  // SizedBox(height: 10),
                  // drugBox('Urine chemistry', 'view'),
                  // SizedBox(height: 10),
                  // drugBox('General Haematology', 'view'),
                  // TestResultsButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget drugBox(Tests testresult) {
    return Material(
      color: Color(0xffF3F4F8),
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TestResultsDetails(
                title: '',
                testdetails: testresult,
              ),
            ),
          );
        },
        child: Container(
          // margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            // color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                testresult.testName.name,
                style: TextStyle(
                  color: Color(0xff071232),
                  fontSize: sizer(true, 16, context),
                ),
              ),
              Container(
                height: 25,
                padding: EdgeInsets.symmetric(horizontal: 14.6),
                decoration: BoxDecoration(
                  color: Color(0xffDFE8FC),
                  borderRadius: BorderRadius.circular(14.6),
                ),
                child: Center(
                  child: Text(
                    'view',
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
        // ],
        // ),
      ),
    );
  }

  // Widget TestResultsButton() {
  //   return Material(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(40.0),
  //       // side: BorderSide(color: Colors.red)
  //     ),
  //     color: Color(0xffF3F4F8),
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: Container(
  //         height: 41,
  //         margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
  //         decoration: BoxDecoration(
  //           color: Color(0xffF3F4F8),
  //           borderRadius: BorderRadius.circular(40),
  //         ),
  //         child: Center(
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               ClipRRect(
  //                   borderRadius: BorderRadius.circular(12),
  //                   child: Container(
  //                     width: 24,
  //                     height: 24,
  //                     color: Color(0xff2254D3),
  //                     child: Text(
  //                       '+',
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 19,
  //                           fontWeight: FontWeight.w700),
  //                     ),
  //                   )),
  //               SizedBox(width: 7.5),
  //               Text(
  //                 'Add self TestResults',
  //                 style: TextStyle(
  //                   color: Color(0xff2254D3),
  //                   fontSize: sizer(true, 16.0, context),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
