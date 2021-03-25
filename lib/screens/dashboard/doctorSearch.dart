import 'dart:io';
import 'package:thcMobile/helpers/store.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/models/hospitalService.dart';
import 'package:thcMobile/models/request.dart';
import './components/goToDoctorBox.dart';
import 'doctorInfo.dart';
import 'package:thcMobile/provider/user.dart';
import 'requests.dart';

class DoctorSearch extends StatefulWidget {
  DoctorSearch({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _DoctorSearchState createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  String currentTab = 'search';
  String activeBox = 'ALL';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  bool loading = false;
  bool speciality = false;
  List<Request> requests = [];
  HospitalService chosenHospitalService;
  List<HospitalService> initialItems = [];
  List<Doctor> doctors;
  List doctorData = [];
  var searchedDoctors;
  bool isLoading = false;
  List subServices = [];
  Timer _refreshFactor;
  String suffix;
  bool newRequest = false;

  @override
  void initState() {
    super.initState();
    this.offlineData();
  }

  Future<Null> offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted &&
        prefs.containsKey("doctors") &&
        prefs.containsKey("subServices"))
      setState(() {
        doctorData = jsonDecode(prefs.getString("doctors"));
        subServices = jsonDecode(prefs.getString("subServices"));
      });
    else
      setState(() {
        isLoading = true;
      });
    if (prefs.containsKey("patientRequests")) if (jsonDecode(
            prefs.getString("patientRequests")) !=
        []) setState(() => newRequest = true);
    return this.fetchDoctors();
  }

  Future<Null> _filterSearch(int id) async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    textController.text.isNotEmpty
        ? suffix = "doctor/?search=${textController.text}&specialization=$id"
        : suffix = "doctor/?specialization=$id";
    _refreshFactor.cancel();
    try {
      var response = await http.get(url + suffix);
      setState(() {
        doctorData = jsonDecode(response.body);
      });
      print(jsonDecode(response.body));
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    }
  }

  void _refreshState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const oneSecond = const Duration(seconds: 1);
    _refreshFactor = new Timer.periodic(
        oneSecond,
        (Timer t) => setState(() {
              if (textController.text.isEmpty)
                doctorData = jsonDecode(prefs.getString("doctors"));
            }));
  }

  Future<Null> getHSData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(url + "hospital-services/", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() {
      subServices = jsonDecode(response.body);
    });
    prefs.setString("subServices", response.body);

    this._refreshState();
  }

  Future<Null> search() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    if (textController.text.isNotEmpty)
      try {
        var response =
            await http.get(url + "doctor/?search=${textController.text}");
        setState(() {
          doctorData = jsonDecode(response.body);
        });
        print(jsonDecode(response.body));
      } on SocketException {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No internet connection!",
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      }
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Field is required!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
  }

  Future<Null> fetchDoctors() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(url + "doctor/");
      setState(() {
        doctorData = jsonDecode(response.body);
        isLoading = false;
      });
      prefs.setString("doctors", response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
      setState(() {
        isLoading = false;
      });
    }
    return this.getHSData();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshFactor.cancel();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  bottom: 27,
                  top: sizer(false, 50, context),
                  left: sizer(true, 20, context),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff071232),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BackButtonBlack(onPressed: () {
                        Navigator.pop(context);
                      }),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: WhiteHeaderText(title: 'Find a doctor'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F4F8),
                ),
                padding: EdgeInsets.only(
                    top: 20, left: 45, right: sizer(true, 20, context)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    currentTab == 'search'
                        ? Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                                onTap: () {
                                  if (mounted)
                                    setState(() {
                                      currentTab = 'search';
                                    });
                                },
                                child: activeTab('Search')))
                        : Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                                onTap: () {
                                  if (mounted)
                                    setState(() {
                                      currentTab = 'search';
                                    });
                                },
                                child: inactiveTab('Search'))),
                    SizedBox(width: 60),
                    currentTab == 'requests'
                        ? Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                                onTap: () {
                                  if (mounted)
                                    setState(() {
                                      currentTab = 'requests';
                                    });
                                },
                                child: activeTab('Requests')))
                        : Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                if (mounted)
                                  setState(() {
                                    currentTab = 'requests';
                                  });
                              },
                              child: inactiveTab('Requests'),
                            ),
                          ),
                  ],
                ),
              ),
              currentTab == 'search' ? doctorsWidget() : Container(),
              currentTab == 'requests'
                  ? loading
                      ? CenterLoader()
                      : RequestsWidget()
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorsWidget() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(right: sizer(true, 20, context), left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              SearchTextInput(
                hintText: 'Search',
                onChanged: (text) {},
                textController: textController,
                action: search,
              ),
              SizedBox(height: 19),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    allBox('ALL', 60, 0, true),
                    isLoading
                        ? Row(
                            children: List.generate(
                              5,
                              (index) => allBox(
                                  '',
                                  MediaQuery.of(context).size.width * 0.35,
                                  1,
                                  true),
                            ),
                          )
                        : Row(
                            children: List.generate(
                              subServices.length,
                              (index) => allBox(
                                  subServices[index]['name']
                                      .toString()
                                      .toUpperCase(),
                                  MediaQuery.of(context).size.width * 0.35,
                                  subServices[index]['id'],
                                  false),
                            ),
                          )
                    // initialItems != null && initialItems.length > 0
                    //     : EmptyData(title: 'No doctors available', isButton: false),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                    '${doctorData.length ?? 0} registered doctor${doctorData.length == 1 ? '' : 's'}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: pixel24,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: sizer(false, 25, context)),
                doctorData == []
                    ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: EmptyData(
                            title: 'No results found!', isButton: false),
                      )
                    : isLoading
                        ? CenterLoader()
                        : Expanded(
                            child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: doctorData.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return GoToDoctorBox(
                                doctor: doctorData != []
                                    ? Doctor.fromJson(doctorData[index])
                                    : Doctor(),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => DoctorInfo(
                                            myId: null,
                                            myAvatar: null,
                                            myName: null,
                                            myDoctor: false,
                                            hasSubscribed: false,
                                            doctor: Doctor.fromJson(
                                                doctorData[index]))),
                                  );
                                },
                              );
                            },
                          )),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  Widget activeTab(String tabName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            children: [
              Text(tabName,
                  style: TextStyle(
                      color: blue, fontSize: sizer(true, 16.0, context))),
              SizedBox(width: 5),
              newRequest && tabName == 'Requests'
                  ? Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(height: sizer(false, 15, context)),
        Container(
          width: 55,
          height: 3,
          decoration: BoxDecoration(
            color: Color(0xff071232),
          ),
        )
      ],
    );
  }

  Widget inactiveTab(String tabName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            children: [
              Text(tabName,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              SizedBox(width: 5),
              newRequest && tabName == 'Requests'
                  ? Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(height: sizer(false, 15, context)),
        Container(
          width: 55,
          height: 3,
          decoration: BoxDecoration(color: Colors.transparent),
        )
      ],
    );
  }

  Widget allBox(String title, double width, [int id, bool active]) {
    return Container(
        width: width,
        margin: EdgeInsets.only(right: 7.0),
        child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: activeBox == title ? Color(0xff2254D3) : Color(0xffF3F4F8),
            child: GestureDetector(
                onTap: () {
                  setState(() => activeBox = title);
                  id != null && id > 0 ? _filterSearch(id) : fetchDoctors();
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.5, horizontal: 16.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        '$title',
                        style: TextStyle(
                          color:
                              activeBox == title ? Colors.white : Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )))));
  }
}
