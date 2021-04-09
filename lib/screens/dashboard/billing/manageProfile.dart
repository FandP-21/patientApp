import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/models/patient.dart';
import 'package:http/http.dart' as http;

class ManageProfile extends StatefulWidget {
  ManageProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  bool loading = false;
  Patient patient = Patient();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController maritalController = TextEditingController();
  TextEditingController tribeController = TextEditingController();
  TextEditingController ninPassportController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController medicalConditionController = TextEditingController();
  TextEditingController nextOfController = TextEditingController();
  TextEditingController kinPhoneController = TextEditingController();
  TextEditingController kinAddressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController genoTypeController = TextEditingController();
  TextEditingController bloodSugarController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
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
    Response response;
    Dio dio = new Dio();
    response = await dio
        .get(
      url + "patient-list/" + id + '/',
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          }),
    )
        .catchError((e) {
      if (mounted)
        setState(() {
          loading = false;
        });
      print(e.response.data);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
      } else {
        message = e.response.data.toString();
      }
    });
    if (mounted)
      setState(() {
        loading = false;
      });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['details'] != null) {
        message = response.data['details'];
      } else {
        message = response.data.toString();
      }
    }
    print(responseJson);
    if (mounted)
      setState(() {
        patient = Patient.fromJson(responseJson);
        nameController.text = patient.user!=null?patient.user.name:'';
        dobController.text = patient.dateOfBirth!= null?patient.dateOfBirth:'';
        phoneController.text = patient.phoneNumber!= null?patient.phoneNumber:'N/A';
        currentAddressController.text = patient.address!= null?patient.address:'';
        occupationController.text = patient.occupation!= null?patient.occupation:'';
        maritalController.text = patient.maritalStatus!= null?patient.maritalStatus:'';
        tribeController.text = patient.tribe!= null?patient.tribe:'';
        ninPassportController.text = patient.ninNumber!= null? patient.ninNumber:'';
        medicalConditionController.text = patient.existingConditions!= null?patient.existingConditions:'';
        medicalConditionController.text = patient.existingConditions!= null?patient.existingConditions:'';
        kinPhoneController.text = patient.nextOfKinPhoneNumber!= null?patient.nextOfKinPhoneNumber:'';
        kinAddressController.text = patient.nextOfKinAddress!= null?patient.nextOfKinAddress:'';
        genderController.text = patient.gender!= null? patient.gender:'';
        ageController.text = patient.age!= null?patient.age.toString():'';
        heightController.text = patient.height!= null? patient.height:'';
        weightController.text = patient.weight!= null?patient.weight:"";
        bloodGroupController.text = patient.bloodGroup!= null?patient.bloodGroup:"";
        genoTypeController.text = patient.haemoglobinGenotype!= null?patient.haemoglobinGenotype:"";
        bloodSugarController.text = patient.bloodSugar!= null?patient.bloodSugar:"";
        allergiesController.text = patient.allergies!= null?patient.allergies:"";
        emailController.text = patient.user!= null?patient.user.email:'';
        nextOfController.text = patient.nextOfKinName;
      });
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
                    child: SingleChildScrollView(
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
                                HeaderText(title: 'Patient Profile'),
                                SizedBox(height: 19),
                                loading
                                    ? SizedBox()
                                    : Column(
                                  children: [
                                    dataBox('Name', nameController.text, false,(v){
                                      nameController.text = v;
                                    }),
                                    dataBox(
                                        'Date of birth',
                                        dobController.text,
                                        true,(v){
                                      dobController.text = v;
                                    }),
                                    dataBox('Phone number',
                                        phoneController.text, true,(v){
                                          phoneController.text = v;
                                        }),
                                    dataBox(
                                        'Current Address',currentAddressController.text,
                                        true,(v){
                                      currentAddressController.text = v;
                                    }),
                                    dataBox(
                                        'Occupation',
                                        occupationController.text ,
                                        true,(v){
                                      occupationController.text = v;
                                    }),
                                    dataBox(
                                        'Marital Status',
                                        maritalController.text,
                                        true,(v){
                                      maritalController.text = v;
                                    }),
                                    dataBox(
                                        'Tribe',
                                        tribeController.text,
                                        true,(v){
                                      tribeController.text = v;
                                    }),
                                    dataBox(
                                        'NIN/Passport Number',
                                        ninPassportController.text,
                                        true,(v){
                                      ninPassportController.text = v;
                                    }),
                                    dataBox(
                                        'Email',
                                        emailController.text,
                                        false,(v){
                                      emailController.text = v;
                                    }),
                                    dataBox(
                                        'Existing Medical Condition',
                                        medicalConditionController.text,
                                        true,(v){
                                      medicalConditionController.text = v;
                                    }),
                                    dataBox(
                                        'Next of Kin',
                                        nextOfController.text,
                                        true,(v){
                                      nextOfController.text = v;
                                    }),
                                    dataBox(
                                        'Next of Kin Phone Number',
                                        kinPhoneController.text,
                                        true,(v){
                                      kinPhoneController.text = v;
                                    }),
                                    dataBox(
                                        'Address of Next of Kin',
                                        kinAddressController.text,
                                        true,(v){
                                      kinAddressController.text = v;
                                    }),
                                    SizedBox(height: 29),
                                    Container(
                                        height: 1.0,
                                        color: Color.fromRGBO(
                                            142, 145, 156, 0.24)),
                                    SizedBox(height: 39),
                                    SubText(title: 'Biodata', isCenter: true),
                                    SizedBox(height: 24),
                                    dataBox(
                                        'Gender',
                                        genderController.text,
                                        true,(value){
                                      genderController.text = value;
                                    }),
                                    dataBox(
                                        'Age',
                                        ageController.text,
                                        true,(v){
                                      ageController.text = v;
                                    }),
                                    dataBox(
                                        'Height',
                                        heightController.text,
                                        true,(v){
                                      heightController.text = v;
                                    }),
                                    dataBox(
                                        'Weight',
                                        weightController.text,
                                        true,(v){
                                      weightController.text = v;
                                    }),
                                    dataBox(
                                        'Blood Group',
                                        bloodGroupController.text,
                                        true,(v){
                                      bloodGroupController.text = v;
                                    }),
                                    dataBox(
                                        'GenoType',
                                        genoTypeController.text,
                                        true,(v){
                                      genoTypeController.text = v;
                                    }),
                                    dataBox(
                                        'Blood Sugar',
                                        bloodSugarController.text,
                                        true,(v){
                                      bloodSugarController.text = v;
                                    }),
                                    dataBox(
                                        'Allergies',
                                        allergiesController.text,
                                        true,(v){
                                      allergiesController.text = v;
                                    }),
                                    SizedBox(height: 20),
                                    ButtonBlue(
                                        title: "UPDATE",
                                        onPressed: () async {
                                          setState(() {
                                          });
                                          String url = Provider.of<UserModel>(context, listen: false).baseUrl;
                                          String token = Provider.of<UserModel>(context, listen: false).token;
                                          String id = Provider.of<UserModel>(context, listen: false).id;
                                          Map<String ,dynamic> body = Map();
                                          if (dobController.text.isNotEmpty){
                                            body['date_of_birth'] = dobController.text;
                                          } else if (phoneController.text.isNotEmpty){
                                            body['phone_number'] = phoneController.text;
                                          } else if (heightController.text.isNotEmpty){
                                            body['height'] = heightController.text;
                                          } else if (tribeController.text.isNotEmpty){
                                            body['tribe'] = tribeController.text;
                                          } else if (currentAddressController.text.isNotEmpty){
                                            body['address'] = currentAddressController.text;
                                          } else if (occupationController.text.isNotEmpty){
                                            body['occupation'] = occupationController.text;
                                          } else if (maritalController.text.isNotEmpty){
                                            body['marital_status'] = maritalController.text;
                                          } else if (ninPassportController.text.isNotEmpty){
                                            body['nin_number'] = ninPassportController.text;
                                          }else if (medicalConditionController.text.isNotEmpty){
                                            body['existing_conditions'] = medicalConditionController.text;
                                          }else if (nextOfController.text.isNotEmpty){
                                            body['next_of_kin_name'] = nextOfController.text;
                                          } else if (kinPhoneController.text.isNotEmpty){
                                            body['next_of_kin_phone_number'] = kinPhoneController.text;
                                          }else if (kinAddressController.text.isNotEmpty){
                                            body['next_of_kin_address'] = kinAddressController.text;
                                          }else if (genderController.text.isNotEmpty){
                                            body['gender'] = genderController.text;
                                          }else if (ageController.text.isNotEmpty){
                                            body['age'] = ageController.text;
                                          }else if (weightController.text.isNotEmpty){
                                            body['weight'] = "${weightController.text}";
                                          }else if (genoTypeController.text.isNotEmpty){
                                            body['haemoglobin_genotype'] = genoTypeController.text;
                                          }else if (bloodGroupController.text.isNotEmpty){
                                            body['blood_group'] = bloodGroupController.text;
                                          }else if (bloodSugarController.text.isNotEmpty){
                                            body['blood_sugar'] = bloodSugarController.text;
                                          }else if (allergiesController.text.isNotEmpty){
                                            body['allergies'] = allergiesController.text;
                                          }
                                          final response = await http.patch(url + "patient-list/" + id+'/' ,body:body ,
                                              headers: {
                                                "Connection": 'keep-alive',
                                                "Authorization": "Bearer " + token
                                              });
                                          print(response.body);
                                          if (response.statusCode == 200){
                                            Fluttertoast.showToast(
                                                msg: "Successful!");
                                            setState(() {
                                              patient = Patient.fromJson(json.decode(response.body));
                                            });
                                          }
                                        }),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ]),
                        )))),
            isLoading: loading));
  }

  Widget dataBox(String title, String data, bool enabled,ValueChanged<String> onChanged) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  color: Color(0xff2254D3),
                  fontSize: sizer(true, 14, context))),
          SizedBox(height: 15),
          Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
              height: 55,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: AuthTextInput(
                enabled: enabled,
                controller: TextEditingController(text: data),
                onChanged: (value){
                  onChanged(value);
                },
              ),
            )
          ])
        ]);
  }
}
