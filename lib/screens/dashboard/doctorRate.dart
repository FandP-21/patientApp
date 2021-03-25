import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/models/hospital.dart';
import 'package:thcMobile/models/pharmacy.dart';
import 'package:thcMobile/provider/user.dart';

class DoctorRate extends StatefulWidget {
  DoctorRate(
      {Key key,
      this.title,
      this.doctor,
      @required this.isHospital,
      @required this.isPharmacy,
      this.pharmacy,
      this.hospital})
      : super(key: key);
  final String title;
  final Doctor doctor;
  final bool isHospital;
  final bool isPharmacy;
  final Hospital hospital;
  final Pharmacy pharmacy;

  @override
  _DoctorRateState createState() => _DoctorRateState();
}

class _DoctorRateState extends State<DoctorRate> {
  double _userRating = 3.0;
  IconData _selectedIcon;
  @override
  void initState() {
    super.initState();
  }

  Future<Null> rateDoctor() async {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    try {
      var response = http.post(url + "rate-doctor/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      }, body: {
        "rating": 4.toString(),
        "doctor": widget.doctor.id.toString(),
      });
      Fluttertoast.showToast(msg: "Successful!");
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } catch (e) {
      Fluttertoast.showToast(msg: "Falied!");
    }
  }

  Future<Null> rateHospital() async {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    try {
      var response = http.post(url + "rate-hospital/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      }, body: {
        "rating": 4.toString(),
        "hospital": widget.hospital.id.toString(),
      });
      Fluttertoast.showToast(msg: "Successful!");
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } catch (e) {
      Fluttertoast.showToast(msg: "Falied!");
    }
  }

  Future<Null> ratePharmacy() async {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    try {
      var response = http.post(url + "rate-pharmacy/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      }, body: {
        "rating": 4.toString(),
        "pharmacy": widget.pharmacy.id.toString(),
      });
      Fluttertoast.showToast(msg: "Successful!");
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } catch (e) {
      Fluttertoast.showToast(msg: "Falied!");
    }
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 19),
                        widget.isHospital
                            ? HeaderText(
                                title: "${widget.hospital.user.username}")
                            : widget.isPharmacy
                                ? HeaderText(
                                    title: "${widget.pharmacy.user.username}")
                                : HeaderText(
                                    title: "${widget.doctor.user.name}"),
                        widget.isHospital
                            ? SubText(title: "", isCenter: false)
                            : widget.isPharmacy
                                ? SubText(title: "", isCenter: false)
                                : SubText(
                                    title: 'Treated you for diabetes',
                                    isCenter: true,
                                  ),
                        SizedBox(height: sizer(false, 7, context)),
                        widget.isHospital
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: Image.network('widget.hospital.photo',
                                    fit: BoxFit.cover, width: 150, height: 150))
                            : widget.isPharmacy
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(widget.pharmacy.photo,
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(widget.doctor.photo,
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150)),
                        SizedBox(height: 50),
                        RatingBarIndicator(
                          rating: _userRating,
                          itemBuilder: (context, index) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction: Axis.horizontal,
                        ),
                        SizedBox(height: 50),
                        ButtonBlue(
                            title: 'CONFIRM RATING',
                            onPressed: () {
                              print("tapped!");
                              if (widget.isHospital == true) {
                                rateHospital();
                              } else if (widget.isPharmacy == true) {
                                ratePharmacy();
                              } else {
                                rateDoctor();
                              }
                            })
                      ]),
                )))));
  }
}
