import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'dart:async';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/models/pharmacy.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/models/hospitalBilling.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/medication/drugDetails.dart';
import 'package:thcMobile/screens/dashboard/pharmacy/components/pharmacyExtendedInfo.dart';

class PharmacyInfo extends StatefulWidget {
  PharmacyInfo({Key key, this.title, this.pharmacy}) : super(key: key);
  final String title;
  final Pharmacy pharmacy;

  @override
  _PharmacyInfoState createState() => _PharmacyInfoState();
}

class _PharmacyInfoState extends State<PharmacyInfo> {
  final TextEditingController controller = new TextEditingController();
  bool loadingData = true;
  String tab = 'None';
  List _drugCategories = [];
  Map<String, dynamic> _pharmacyDrugs = {};

  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("pharmacyDrugCategories")) {
      setState(() => _drugCategories =
          jsonDecode(prefs.getString("pharmacyDrugCategories")));
      setState(() {
        tab = _drugCategories[0];
      });
    } else {
      setState(() {
        loadingData = true;
      });
    }
    this.drugCategories();
  }

  Future<Null> drugCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int pharmacyId = widget.pharmacy.id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Dio dio = new Dio();
    Response response;

    response = await dio.get(
        url + "pharmacy-drug-categories/?pharmacy=$pharmacyId",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));

    List _store = response.data;
    List _cacheDrugCategories = [];
    for (int i = 0; i < _store.length; i++) {
      setState(() {
        _cacheDrugCategories.add(_store[i]['name']);
      });
    }
    setState(() {
      _drugCategories = _cacheDrugCategories;
      tab = _drugCategories[0];
    });
    prefs.setString("pharmacyDrugCategories", jsonEncode(_drugCategories));
    this._fetchDrugs();
  }

  Future<Null> _fetchDrugs() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Dio dio = new Dio();
    Response response;

    response = await dio.get(url + "pharmacy-drug/",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));

    List _store = response.data;

    for (int j = 0; j < _drugCategories.length; j++) {
      _pharmacyDrugs[_drugCategories[j]] = [];
      for (int i = 0; i < _store.length; i++) {
        if (_store[i]['drug_type']['name'] == _drugCategories[j]) {
          setState(() {
            _pharmacyDrugs[_drugCategories[j]].add(_store[i]);
          });
        }
      }
    }
    setState(() => loadingData = false);

    print(_pharmacyDrugs);
  }

  setTab() {
    return tab;
  }

  @override
  void dispose() {
    controller.dispose();
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
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 48, horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color(0xff071232),
                        ),
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              BackButtonBlack(
                                onPressed: () => Navigator.pop(context),
                              ),
                              Spacer(),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xff2A3450),
                                  borderRadius: BorderRadius.circular(55 / 2),
                                ),
                                child: Image.asset(
                                  'assets/images/pharmacyIcon.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 19),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              WhiteHeaderText(
                                  title: widget.pharmacy.user.username),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    PharmacyExtendedInfo(
                                                        pharmacy:
                                                            widget.pharmacy,
                                                        title: '')));
                                      },
                                      icon: Icon(Icons.info,
                                          color: Color(0xff87869a),
                                          size: sizer(true, 16, context)))),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SearchTextInput(
                            altColor: Colors.transparent,
                            hintText: 'Search drugs',
                            textController: controller,
                          ),
                        ]),
                      ),
                      Container(
                        height: 62,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffF3F4F8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ListView.builder(
                              itemCount: _drugCategories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) =>
                                  activeTab(_drugCategories[index], index)),
                        ),
                      ),
                      SizedBox(height: 19),
                      loadingData
                          ? CenterLoader()
                          : tab == setTab() && loadingData == false
                              ? Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: _pharmacyDrugs[setTab()].length > 0
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              _pharmacyDrugs[setTab()].length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              drugPanel(DrugWidget(
                                                  title: HospitalBilling.fromJson(
                                                          _pharmacyDrugs[setTab()]
                                                              [index])
                                                      .name,
                                                  location: "Beecham group",
                                                  amount: HospitalBilling.fromJson(
                                                          _pharmacyDrugs[setTab()]
                                                              [index])
                                                      .price)))
                                      : EmptyData(
                                          title: "No data",
                                          isButton: false,
                                        ))
                              : SizedBox(),
                    ])))));
  }

  Widget drugPanel(DrugWidget drug) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/drugImage.png',
                  width: 55, height: 55, fit: BoxFit.contain)),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(drug.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Text(drug.location,
                  style: TextStyle(
                      color: Color(0xff8E919C),
                      fontSize: sizer(true, 16.0, context))),
            ],
          )),
          Spacer(),
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 14.6),
            decoration: BoxDecoration(
              color: Color(0xffDFE8FC),
              borderRadius: BorderRadius.circular(14.6),
            ),
            child: Center(
                child: Text(drug.amount.toString(),
                    style: TextStyle(
                        color: Color(0xff2254D3),
                        fontSize: sizer(true, 14, context)))),
          )
        ],
      ),
    );
  }

  Widget activeTab(String tabName, int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(tabName,
                style: TextStyle(
                    color: Color(0xff2254D3),
                    fontSize: sizer(true, 14, context))),
            SizedBox(height: sizer(false, 15, context)),
            tab == tabName
                ? Container(
                    width: 50,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xff071232),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
      onTap: () => setState(() => tab = tabName),
    );
  }
}
