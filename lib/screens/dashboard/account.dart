import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/billing/manageProfile.dart';
import 'package:thcMobile/screens/loader.dart';
import 'components/accountListItem.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/mediumText.dart';
import './billing/billingDetails.dart';
import './billing/paymentHistory.dart';
import './personalProfile/index.dart';
import './medicalRecords/index.dart';
import 'linkedDevices.dart';
import 'dart:convert';
import './personalProfile/changePassword.dart';

class Account extends StatefulWidget {
  Account({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic> patientData = {};

  @override
  void initState() {
    super.initState();
    this._getPatient();
  }

  Future<Null> handleSignOut() async {
    Fluttertoast.showToast(msg: "Signing out");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loader()));
  }

  Future _getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      patientData = jsonDecode(prefs.getString("patient"));
    });
    print('\n\n\n\n\n\n\n\n');
    print(patientData['photo']);
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
                            right: sizer(true, 20, context)),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Account',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: pixel28,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      SizedBox(
                                          height: sizer(false, 5, context)),
                                      MediumText(title: 'Manage your account')
                                    ],
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(22.5),
                                      child: patientData['photo'] != null
                                          ? Image.network(
                                          'http://thc2020.herokuapp.com' +
                                              patientData['photo'],
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48)
                                          : Image.asset(
                                          'assets/images/alt-dp.png',
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48)),
                                ],
                              ),
                              SizedBox(height: 25),
                              SearchTextInput(
                                hintText: 'Search',
                              ),
                              SizedBox(height: 35),
                              Text('Medical details',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: pixel18,
                                      fontWeight: FontWeight.w600)),
                              AccountListItem(
                                  last: false,
                                  title: 'Health profile',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => PersonalProfile()),
                                    );
                                  }),
                              AccountListItem(
                                  last: true,
                                  title: 'Medical Records',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => MedicalRecords()),
                                    );
                                  }),
                              SizedBox(height: sizer(false, 30, context)),
                              Text('Payments',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: pixel18,
                                      fontWeight: FontWeight.w600)),
                              AccountListItem(
                                  last: false,
                                  title: 'Billing details',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => BillingDetails()),
                                    );
                                  }),
                              AccountListItem(
                                  last: true,
                                  title: 'Payment history',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => PaymentHistory()),
                                    );
                                  }),
                              SizedBox(height: sizer(false, 40, context)),
                              Text('Account',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: pixel18,
                                      fontWeight: FontWeight.w600)),
                              // AccountListItem(
                              //     last: false,
                              //     title: 'Linked devices',
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //             builder: (_) => LinkedDevices()),
                              //       );
                              //     }),
                              AccountListItem(
                                  last: false,
                                  title: 'Manage profile',
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => ManageProfile()),
                                  )),
                              AccountListItem(
                                  last: false,
                                  title: 'Change password',
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => ChangePassword()),
                                  )),
                              AccountListItem(
                                  last: true,
                                  title: 'FAQ',
                                  onPressed: () => {}),
                              SizedBox(height: sizer(false, 40, context)),
                              Text('Backup',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: pixel18,
                                      fontWeight: FontWeight.w600)),
                              AccountListItem(
                                  last: false,
                                  title: 'Backup health data to iCloud',
                                  onPressed: () {}),
                              AccountListItem(
                                  last: true,
                                  title: 'Share app with friends',
                                  onPressed: (){
                                    RenderBox box = context.findRenderObject() as RenderBox;
                                    Share.share("https://flutter.dev",
                                        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

                                  }),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.9,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2254D3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SIGN OUT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                onTap: () => handleSignOut(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ]))))));
  }
}
