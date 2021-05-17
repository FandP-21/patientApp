import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/moreButton.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/utils/call_utilities.dart';

class AddSelfMedication extends StatefulWidget {
  AddSelfMedication({Key key, this.title, @required this.updateState})
      : super(key: key);
  final String title;
  final VoidCallback updateState;

  @override
  _AddSelfMedicationState createState() => _AddSelfMedicationState();
}

class _AddSelfMedicationState extends State<AddSelfMedication> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController noOfTablets = new TextEditingController(text: "25");
  TextEditingController dosage = new TextEditingController(text: '25');
  TextEditingController drugs = new TextEditingController(text: 'test');
  String _unit = 'mg';
  bool _autoValidate = false;
  bool loading = false;
  String _treatmentCategory = 'Select treatment category';
  String _drugName = 'Select drug';
  int _drugId;
  String _frequency = 'per 8 hours';
  String _times = '2 times';
  @override
  void initState() {
    super.initState();
  }

  Future<Null> addMedication() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    setState(() => loading = true);
    var response = await http.post(url + 'self-medication/$id', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      // "name": _treatmentCategory,
      // "patient": id.toString(),
      "drug_sets[0]dosage": dosage.text,
      "drug_sets[0]patient": id.toString(),
      "drug_sets[0]frequency": _frequency.toString(),
      "drug_sets[0]unit": _unit.toString(),
      "drug_sets[0]no_of_tablets": noOfTablets.text,
      "drug_sets[0]drug": drugs.text,
      "drug_sets[0]name": _drugName,
    });
    setState(() => loading = false);
    if (response.statusCode == 200){
      print(jsonDecode(response.body));
      await widget.updateState();
      Fluttertoast.showToast(msg: 'Successful!');
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    }else{
      Fluttertoast.showToast(msg: 'Error!');
    }
  }

  @override
  void dispose() {
    noOfTablets.dispose();
    drugs.dispose();
    dosage.dispose();
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
          child: Padding(
            padding: EdgeInsets.only(
                top: sizer(false, 50, context),
                left: sizer(true, 20, context),
                right: sizer(true, 20, context)),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BackButtonWhite(
                      onPressed: () {},
                    ),
                    MoreButton(onPressed: () {})
                  ],
                ),
                SizedBox(height: sizer(false, 15, context)),
                HeaderText(title: 'Add self medication'),
                SizedBox(height: sizer(false, 7, context)),
                RichText(
                  text: TextSpan(
                    text: 'Current treatment: ',
                    style: TextStyle(
                        color: Color(0xff828A95),
                        fontSize: sizer(true, 14, context)),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Diabetes ',
                          style: TextStyle(color: Color(0xff245de8))),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                customForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
              child: AuthTextInput(
                  hintText: 'Name of drug',
                  onChanged: (text) {},
                  controller: drugs,
                  altTextColor: blue,
                  border: BorderSide(
                    color: Color(0xff245DE8),
                  )),
            ),
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: AuthTextInput(
                          hintText: 'Enter dosage',
                          onChanged: (text) {},
                          controller: dosage,
                          altTextColor: blue,
                          border: BorderSide(color: blue),
                        )
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      margin:
                      EdgeInsets.only(bottom: sizer(false, 0, context)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xffF3F4F8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          hint: Text(
                            _unit,
                            style: TextStyle(
                                color: Color(0xff2254D3),
                                fontFamily: 'SofiaPro',
                                fontSize: sizer(true, 16.0, context)),
                          ),
                          items: ['mg', 'g'].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: () {
                                setState(() {
                                  _unit = value;
                                  // hospitalID =
                                  //     ids[hospitals.indexOf(value)];
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {});
                          },
                          isExpanded: true,
                          style: TextStyle(
                              color: Color(0xff828A95),
                              fontFamily: 'SofiaPro',
                              fontSize: 14),
                          underline: SizedBox(),
                          dropdownColor: Colors.white,
                          iconDisabledColor: Color(0xff2254D3),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Color(0xff2254D3),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xffF3F4F8),
                        border: Border.all(
                          color: blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        hint: Text(
                          "Daily",
                          style: TextStyle(
                              color: Color(0xff2254D3),
                              fontFamily: 'SofiaPro',
                              fontSize: sizer(true, 16.0, context)),
                        ),
                        items: ['per 2 hours', 'per 4 hours', 'per 6 hours']
                            .map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: () {
                              setState(() {
                                _frequency = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {});
                        },
                        isExpanded: true,
                        style: TextStyle(
                            color: Color(0xff828A95),
                            fontFamily: 'SofiaPro',
                            fontSize: 14),
                        underline: SizedBox(),
                        dropdownColor: Colors.white,
                        iconDisabledColor: Color(0xff2254D3),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: Color(0xff2254D3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xffF3F4F8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        hint: Text(
                          _times,
                          style: TextStyle(
                              color: Color(0xff2254D3),
                              fontFamily: 'SofiaPro',
                              fontSize: sizer(true, 16.0, context)),
                        ),
                        items: ['2 times', '3 times', '4 times'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: () {
                              setState(() {
                                _times = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {});
                        },
                        isExpanded: true,
                        style: TextStyle(
                            color: Color(0xff828A95),
                            fontFamily: 'SofiaPro',
                            fontSize: 14),
                        underline: SizedBox(),
                        dropdownColor: Colors.white,
                        iconDisabledColor: Color(0xff2254D3),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: Color(0xff2254D3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
              child: AuthTextInput(
                hintText: '25 tablets',
                onChanged: (text) {},
                controller: noOfTablets,
                altTextColor: blue,
                border: BorderSide(color: blue),
              ),
            ),
          ],
        ),
        loading
            ? Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xff245DE8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        )
            : Container(
          margin: EdgeInsets.only(top: 100),
          child: ButtonBlue(
              onPressed: () {
                if(drugs.text.isEmpty){
                  showInSnackBar('Enter Drugs Name',_scaffoldKey,context);
                }else if (dosage.text.isEmpty){
                  showInSnackBar('Enter Dosage',_scaffoldKey,context);
                }else if (noOfTablets.text.isEmpty){
                  showInSnackBar('Enter Tablets',_scaffoldKey,context);
                }else{
                  addMedication();
                }
              },
              title: 'ADD'),
        ),
        SizedBox(
          height: sizer(false, 32, context),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
