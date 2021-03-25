import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/services/paymentMethods.dart';
import '../components/accountListItem.dart';
import './components/greenMeterBox.dart';
import 'package:thcMobile/screens/dashboard/index.dart';

class EnterInfoC extends StatefulWidget {
  EnterInfoC({
    Key key,
    @required this.title,
    @required this.hasPlan,
    @required this.hmoId,
    @required this.hmoPlanId,
    @required this.duration,
    @required this.sixMonthsPrice,
    @required this.oneYearPrice,
    @required this.identifier,
  }) : super(key: key);
  final String title;
  final bool hasPlan;
  final String hmoId;
  final String hmoPlanId;
  final String duration;
  final String sixMonthsPrice, oneYearPrice;
  final String identifier;

  @override
  _EnterInfoCState createState() => _EnterInfoCState();
}

class _EnterInfoCState extends State<EnterInfoC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  List _diseases = [];
  TextEditingController otherConditions = new TextEditingController();
  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _diseases = jsonDecode(prefs.getString("diseases") ?? "[]");
    });
    this._fetchDiseases();
  }

  Future<Null> handlePaymentHMO() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    await PaymentMethods()
        .paystack(context, "426157612576352", "456", 12, 2023, 1000000, (a) {
      Fluttertoast.showToast(msg: a);
    });
    var response = await http.post(url + 'hmo-subscription/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "duration": widget.duration,
      "hmo_plan": widget.hmoPlanId,
      "patient": id,
      "hmo": widget.hmoId,
    });

    print(jsonDecode(response.body));
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                loading: false,
              ),
            ),
            (Route<dynamic> route) => false));
  }

  Future<Null> handlePaymentHospital() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    await PaymentMethods()
        .paystack(context, "426157612576352", "456", 12, 2023, 1000000, (a) {
      Fluttertoast.showToast(msg: a);
    });
    var response = await http.post(url + 'hospital-patient-register/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "duration": widget.duration,
      "hospital_plan": widget.hmoPlanId,
      "patient": id,
      "status": "active",
      "hospital": widget.hmoId,
    });

    print(jsonDecode(response.body));
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                loading: false,
              ),
            ),
            (Route<dynamic> route) => false));
  }

  Future<Null> handlePaymentLab() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    await PaymentMethods()
        .paystack(context, "426157612576352", "456", 12, 2023, 1000000, (a) {
      Fluttertoast.showToast(msg: a);
    });
    var response = await http.post(url + 'lab-subscription/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "description": widget.duration,
      "patient": id,
      "status": "active",
      "laboratory": widget.hmoId,
      "six_months_price": widget.sixMonthsPrice.toString(),
      "one_year_price": widget.oneYearPrice.toString(),
      "name": widget.title,
    });

    print(jsonDecode(response.body));
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                loading: false,
              ),
            ),
            (Route<dynamic> route) => false));
  }

  void _fetchDiseases() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response;
    response = await http.get(url + "hospital-focused-diseases/", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    });
    _diseases = [];
    for (var i = 0; i < jsonDecode(response.body).length; i++)
      setState(() {
        _diseases.add(jsonDecode(response.body)[i]['name']);
      });
    prefs.setString("diseases", jsonEncode(_diseases));
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.78,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
                top: 50,
                bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  HeaderText(title: 'Select ID type'),
                  SizedBox(height: 28),
                  AccountListItem(
                      last: false,
                      title: 'National ID Card/NIN',
                      onPressed: () {}),
                  AccountListItem(
                      last: false,
                      title: 'Driver\'s License',
                      onPressed: () {}),
                ]),
          );
        });
  }

  @override
  void dispose() {
    otherConditions.dispose();
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
                        SizedBox(height: 25),
                        HeaderText(title: widget.title),
                        SizedBox(
                          height: 8,
                        ),
                        SubText(
                            isCenter: false,
                            title:
                                'Fill in your information to complete yur registration'),
                        SizedBox(height: 50),
                        new Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: customForm(context),
                        ),
                      ]),
                ))));
  }

  Widget customForm(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pre-existing health conditions?',
                style: TextStyle(
                    color: Color(0xff071232),
                    fontWeight: FontWeight.w500,
                    fontSize: sizer(true, 16.0, context))),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownWidget(
                title: "Choose an option",
                store: _diseases,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            MultiInput(
              hintText: "Other",
              maxLines: 5,
              minLines: 5,
              controller: otherConditions,
            ),
            SizedBox(height: sizer(false, 50, context)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GreenMeterBox(position: 0),
            SizedBox(height: sizer(false, 30, context)),
            ButtonBlue(
                onPressed: () {
                  if (widget.identifier == 'hmo')
                    handlePaymentHMO();
                  else if (widget.identifier == 'hospital')
                    handlePaymentHospital();
                  else if (widget.identifier == 'lab') handlePaymentLab();
                },
                title: '${widget.hasPlan ? 'CONFIRM' : 'CONFIRM AND PAY'}'),
            SizedBox(height: sizer(false, 30, context)),
          ],
        ),
      ],
    ));
  }
}
