import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/hospitals/components/priceBox.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/models/hospitalBilling.dart';
import 'package:thcMobile/screens/dashboard/pharmacy/lab/labInfo.dart';
import 'package:thcMobile/screens/dashboard/pharmacy/lab/scheduleAppointmentLab.dart';

class LabInfo extends StatefulWidget {
  LabInfo({Key key, @required this.title, @required this.hospital})
      : super(key: key);
  final String title;

  var hospital;

  @override
  _LabInfoState createState() => _LabInfoState();
}

class _LabInfoState extends State<LabInfo> {
  Hospital hospitalData = new Hospital();
  List<String> _categories = [
    'Services',
    'Registration',
    'Health Plans',
    'Consultation',
    'Emergencies',
    'Others',
  ];
  String tab = 'Registration';
  bool loadingData = false;
  List<dynamic> consultationPricing = [];
  List<dynamic> registrationPricing = [];
  List<dynamic> healthPlanPricing = [];
  List<dynamic> otherPricing = [];
  List<dynamic> emergencyPricing = [];
  List<dynamic> services = [];

  @override
  void initState() {
    super.initState();
    this.hospitalBilling();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future<Null> hospitalBilling() async {
    int hospitalId = hospitalData.id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Dio dio = new Dio();
    Response response, responseX;

    response = await dio.get(url + "hospital-billing-r/$hospitalId/",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));
    responseX = await dio.get(url + "hospital-services/$hospitalId/",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));
    List<dynamic> store = response.data;
    services = responseX.data;

    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Registration Pricing') {
        registrationPricing.add(store[i]);
      }
    }

    setState(() => loadingData = false);

    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Health Plan Pricing') {
        healthPlanPricing.add(store[i]);
      }
    }

    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Consultation Pricing') {
        consultationPricing.add(store[i]);
      }
    }

    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Emergency Pricing') {
        emergencyPricing.add(store[i]);
      }
    }

    for (int i = 0; i < store.length; i++) {
      if (store[i]['category']['name'] == 'Other Pricing') {
        otherPricing.add(store[i]);
      }
    }
  }

  Future<Null> fetchCategories() async {
    int hospitalId = hospitalData.id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Dio dio = new Dio();
    Response response;

    response = await dio.get(url + "hospital-pricing-categories/$hospitalId/",
        options: Options(headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }));

    List store = response.data;

    for (var i = 0; i < store.length; i++) {
      _categories.add(store[i]['name']);
    }
    setState(() {
      tab = _categories[0];
      loadingData = false;
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
            child: SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 28, horizontal: 25),
              decoration: BoxDecoration(
                color: Color(0xff071232),
              ),
              child: Column(children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BackButtonBlack(
                      onPressed: () => Navigator.pop(context),
                    ),
                    Spacer(),
                    Container(
                        height: 45,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FlatButton(
                              color: blue,
                              child: Text('Book test',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: pixel16,
                                    fontWeight: normal,
                                  )),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ScheduleAppointmentLab(
                                        hospital: widget.hospital, title: '')));
                              },
                            ))),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(55 / 2),
                                  border: Border.all(
                                    color: inputGrey.withOpacity(0.5),
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )),
                              child: Center(
                                  child: Image.asset(
                                      'assets/images/pharmacyIcon.png',
                                      width: 55,
                                      height: 55))),
                          SizedBox(width: 15),
                          WhiteHeaderText(title: widget.hospital.user.username),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => LabDetails(
                                    hospital: widget.hospital,
                                    title: widget.title)));
                          },
                          icon: Icon(Icons.info_outline,
                              color: Color(0xff87869a),
                              size: sizer(true, 32, context))),
                    ]),
              ]),
            ),
            Container(
              height: 58,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffF3F4F8),
              ),
              padding: EdgeInsets.only(left: 10, top: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                    itemCount: _categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        activeTab(_categories[index], index)),
              ),
            ),
            SizedBox(height: 19),
            loadingData
                ? CenterLoader()
                : tab == _categories[0] && loadingData == false
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: sizer(true, 20, context),
                            right: sizer(true, 20, context)),
                        child: services.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: services.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    PriceBox(
                                        isService: true,
                                        title: HospitalMainServices.fromJson(
                                                services[index])
                                            .name,
                                        amount: null))
                            : EmptyData(
                                title: "No data",
                                isButton: false,
                              ))
                    : SizedBox(),
            tab == _categories[1] && loadingData == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: registrationPricing.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: registrationPricing.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PriceBox(
                                    isService: false,
                                    title: HospitalBilling.fromJson(
                                            registrationPricing[index])
                                        .name,
                                    amount: HospitalBilling.fromJson(
                                            registrationPricing[index])
                                        .price
                                        .toString()))
                        : EmptyData(
                            title: "No data",
                            isButton: false,
                          ))
                : SizedBox(),
            tab == _categories[2] && loadingData == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: healthPlanPricing.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: healthPlanPricing.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PriceBox(
                                    isService: false,
                                    title: HospitalBilling.fromJson(
                                            healthPlanPricing[index])
                                        .name,
                                    amount: HospitalBilling.fromJson(
                                            healthPlanPricing[index])
                                        .price
                                        .toString()))
                        : EmptyData(
                            title: "No data",
                            isButton: false,
                          ))
                : SizedBox(),
            tab == _categories[3] && loadingData == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: consultationPricing.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: consultationPricing.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PriceBox(
                                    isService: false,
                                    title: HospitalBilling.fromJson(
                                            consultationPricing[index])
                                        .name,
                                    amount: HospitalBilling.fromJson(
                                            consultationPricing[index])
                                        .price
                                        .toString()))
                        : EmptyData(
                            title: "No data",
                            isButton: false,
                          ))
                : SizedBox(),
            tab == _categories[4] && loadingData == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: emergencyPricing.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: emergencyPricing.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PriceBox(
                                    isService: false,
                                    title: HospitalBilling.fromJson(
                                            emergencyPricing[index])
                                        .name,
                                    amount: HospitalBilling.fromJson(
                                            emergencyPricing[index])
                                        .price
                                        .toString()))
                        : EmptyData(
                            title: "No data",
                            isButton: false,
                          ))
                : SizedBox(),
            tab == _categories[5] && loadingData == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: otherPricing.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: otherPricing.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PriceBox(
                                    isService: false,
                                    title: HospitalBilling.fromJson(
                                            otherPricing[index])
                                        .name,
                                    amount: HospitalBilling.fromJson(
                                            otherPricing[index])
                                        .price
                                        .toString()))
                        : EmptyData(
                            title: "No data",
                            isButton: false,
                          ))
                : SizedBox(),
          ]),
    )));
  }

  Widget activeTab(String tabName, int index) {
    return GestureDetector(
      child: Container(
        height: 58,
        width: 100,
        margin: EdgeInsets.only(right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(tabName,
                style: TextStyle(
                    color: Color(0xff2254D3),
                    fontSize: sizer(true, 16, context))),
            SizedBox(height: sizer(false, 20, context)),
            tab == tabName
                ? Container(
                    width: 88,
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
