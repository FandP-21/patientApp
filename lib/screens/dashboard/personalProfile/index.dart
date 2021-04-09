import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/models/patient.dart';
import 'package:http/http.dart' as http;

class PersonalProfile extends StatefulWidget {
  PersonalProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  bool loading = true;
  Patient patient = Patient();
  @override
  void initState() {
    super.initState();
    getData();
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
    final response = await http.get(url + "patient-list/" + id ,
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
      if (mounted)
        setState(() {
          patient = Patient.fromJson(responseJson);
        });
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
            child: SafeArea(
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
                                HeaderText(title: 'Health Profile'),
                                SizedBox(height: 19),
                                loading ? SizedBox() : Column(
                                  children: [
                                    dataBox('Name', patient.user!= null?patient.user.name:''),
                                    dataBox(
                                        'Date of birth',
                                        patient.dateOfBirth != null
                                            ? patient.dateOfBirth
                                            : ''),
                                    dataBox('Current Address',
                                        patient.address != null ? patient.address : ''),
                                    dataBox(
                                        'Occupation',
                                        patient.occupation != null
                                            ? patient.occupation
                                            : ''),
                                    dataBox(
                                        'Marital Status',
                                        patient.maritalStatus != null
                                            ? patient.maritalStatus
                                            : ''),
                                    dataBox('Tribe',
                                        patient.tribe != null ? patient.tribe : ''),
                                    dataBox(
                                        'NIN/Passport Number',
                                        patient.ninNumber != null
                                            ? patient.ninNumber
                                            : ''),
                                    dataBox(
                                        'Email',
                                        patient.user != null &&
                                            patient.user.email != null
                                            ? patient.user.email
                                            : ''),
                                    dataBox(
                                        'Existing Medical Condition',
                                        patient.existingConditions != null
                                            ? patient.existingConditions
                                            : ''),
                                    dataBox('Referred by', ''),
                                    dataBox(
                                        'Next of Kin',
                                        patient.nextOfKinName != null
                                            ? patient.nextOfKinName
                                            : ''),
                                    dataBox(
                                        'Next of Kin Phone Number',
                                        patient.nextOfKinPhoneNumber != null
                                            ? patient.nextOfKinPhoneNumber
                                            : ''),
                                    dataBox(
                                        'Address of Next of Kin',
                                        patient.nextOfKinAddress != null
                                            ? patient.nextOfKinAddress
                                            : ''),
                                    SizedBox(height: 29),
                                    Container(
                                        height: 1.0,
                                        color: Color.fromRGBO(142, 145, 156, 0.24)),
                                    SizedBox(height: 39),
                                    SubText(title: 'Biodata', isCenter: false),
                                    SizedBox(height: 24),
                                    dataBox('Gender',
                                        patient.gender != null ? patient.gender : ''),
                                    dataBox(
                                        'Age',
                                        patient.age != null
                                            ? patient.age.toString()
                                            : ''),
                                    dataBox(
                                        'Height',
                                        patient.height != null
                                            ? patient.height + 'cm'
                                            : ''),
                                    dataBox(
                                        'Weight',
                                        patient.weight != null
                                            ? patient.weight + 'kg'
                                            : ''),
                                    dataBox(
                                        'Blood Group',
                                        patient.bloodGroup != null
                                            ? patient.bloodGroup
                                            : ''),
                                    dataBox(
                                        'GenoType',
                                        patient.haemoglobinGenotype != null
                                            ? patient.haemoglobinGenotype
                                            : ''),
                                    dataBox(
                                        'BMI', patient.bmi != null ? patient.bmi : ''),
                                    dataBox(
                                        'Blood Sugar',
                                        patient.bloodSugar != null
                                            ? patient.bloodSugar
                                            : ''),
                                    dataBox(
                                        'Allergies',
                                        patient.allergies != null
                                            ? patient.allergies
                                            : ''),
                                  ],
                                ),
                              ]),
                        )))),
            isLoading: loading));
  }

  Widget dataBox(String title, String data) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: Color(0xff2254D3),
                  fontSize: sizer(true, 14, context))),
          SizedBox(height: 10),
          Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  color: Color(0xffF3F4F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(data != '' ? data : 'N/A',
                    style: TextStyle(
                        color:
                        data != '' ? Color(0xff071232) : Color(0xff828282),
                        fontSize: sizer(true, 16.0, context))))
          ])
        ]);
  }
}
