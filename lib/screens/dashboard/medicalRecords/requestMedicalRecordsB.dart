import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/provider/user.dart';
import '../components/checkListItem.dart';

class RequestMedicalRecordsB extends StatefulWidget {
  RequestMedicalRecordsB(
      {Key key,
      @required this.title,
      @required this.hospital,
      @required this.subTitle,
      @required this.patient,
      @required this.buttonText,
      @required this.doctor,
      @required this.onShare,
      @required this.isRequest,
      @required this.hasIcon})
      : super(key: key);
  final String title, buttonText;
  final bool hasIcon;
  final bool isRequest;
  final VoidCallback onShare;
  final String subTitle;
  final int hospital, patient, doctor;

  @override
  _RequestMedicalRecordsBState createState() => _RequestMedicalRecordsBState();
}

class _RequestMedicalRecordsBState extends State<RequestMedicalRecordsB> {
  bool _vitals = false;
  bool _admission_history = false;
  bool _previous_consultant_notes = false;
  bool _patient_info = false;
  bool _patient_history = false;
  bool _examination_history = false;
  bool _diagnosis_history = false;
  bool _prescription_history = false;
  bool _investigation_history = false;
  bool _lab_results = false;
  bool _notes = false;
  bool _log_history = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> shareMedicalData(
      _vitals,
      _admission_history,
      _previous_consultant_notes,
      _patient_info,
      _patient_history,
      _examination_history,
      _diagnosis_history,
      _prescription_history,
      _investigation_history,
      _lab_results,
      _notes,
      _log_history) {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    // var response;
    // Dio dio = new Dio();

    Map<String, dynamic> data = {
      "vitals": _vitals.toString(),
      // "admission_history": _admission_history,
      "consultant_notes": _previous_consultant_notes.toString(),
      "patient_profile": _patient_info.toString(),
      "patient_history": _patient_history.toString(),
      "examination_history": _examination_history.toString(),
      "diagnosis_history": _diagnosis_history.toString(),
      "prescription_history": _prescription_history.toString(),
      "investigation_history": _investigation_history.toString(),
      "test_results": _lab_results.toString(),
      "notes": _notes.toString(),
      "log_history": _log_history.toString(),
      "patient": id.toString(),
    };

    var response = http.post(
      url + "choose-what-to-share/",
      body: data,
      headers: {"Connection": 'keep-alive', "Authorization": "Bearer " + token},
    );
    print(data);
    print(response.toString());
    Fluttertoast.showToast(msg: "Successful");
    Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
  }

  Future<Null> requestMedicalData(
      _vitals,
      _admission_history,
      _previous_consultant_notes,
      _patient_info,
      _patient_history,
      _examination_history,
      _diagnosis_history,
      _prescription_history,
      _investigation_history,
      _lab_results,
      _notes,
      _log_history) {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    // var response;
    // Dio dio = new Dio();

    Map<String, dynamic> data = {
      "vitals": _vitals.toString(),
      "admission_history": _admission_history,
      "previous_consultant_notes": _previous_consultant_notes.toString(),
      "patient_profile": _patient_info.toString(),
      "patient_history": _patient_history.toString(),
      "examination_history": _examination_history.toString(),
      "diagnosis_history": _diagnosis_history.toString(),
      "prescription_history": _prescription_history.toString(),
      "investigation_history": _investigation_history.toString(),
      "test_results": _lab_results.toString(),
      "notes": _notes.toString(),
      "log_history": _log_history.toString(),
      "patient": id.toString(),
      "start_range": null,
      "end_range": null,
      "hospital": null,
      "doctor": widget.doctor,
    };

    var response = http.post(
      url + "request-medical-records/",
      body: data,
      headers: {"Connection": 'keep-alive', "Authorization": "Bearer " + token},
    ).catchError((e) {
      print("\n\n$e\n\n");
    });

    print(data);
    Fluttertoast.showToast(msg: "Successful");
    Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
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
              child: Stack(children: <Widget>[
                new SingleChildScrollView(
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
                            Opacity(
                                opacity: widget.hasIcon ? 1 : 0,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 11),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F4F8),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/images/file.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.contain)))),
                          ],
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: widget.title),
                        SizedBox(height: 5),
                        Text(widget.subTitle,
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: sizer(true, 16.0, context))),
                        SizedBox(height: 26),
                        CheckListItem(
                          value: _vitals,
                          title: 'Vitals',
                          onChanged: (value) {
                            setState(() {
                              _vitals = value;
                            });
                          },
                        ),
                        CheckListItem(
                          value: _previous_consultant_notes,
                          title: 'Previous consultant notes',
                          onChanged: (value) {
                            setState(() {
                              _previous_consultant_notes = value;
                            });
                          },
                        ),
                        CheckListItem(
                            value: _patient_info,
                            title: 'Patient info',
                            onChanged: (value) {
                              setState(() {
                                _patient_info = value;
                              });
                            }),
                        CheckListItem(
                            value: _patient_history,
                            title: 'Patient history',
                            onChanged: (value) {
                              setState(() {
                                _patient_history = value;
                              });
                            }),
                        CheckListItem(
                          value: _examination_history,
                          title: 'Examination history',
                          onChanged: (value) {
                            setState(() {
                              _examination_history = value;
                            });
                          },
                        ),
                        CheckListItem(
                          value: _diagnosis_history,
                          title: 'Diagonosis history',
                          onChanged: (value) {
                            setState(() {
                              _diagnosis_history = value;
                            });
                          },
                        ),
                        CheckListItem(
                          value: _prescription_history,
                          title: 'Prescription history',
                          onChanged: (value) {
                            setState(() {
                              _prescription_history = value;
                            });
                          },
                        ),
                        CheckListItem(
                          value: _investigation_history,
                          title: 'Investigation history',
                          onChanged: (value) {
                            setState(() {
                              _investigation_history = value;
                            });
                          },
                        ),
                        CheckListItem(
                          value: _lab_results,
                          title: 'Lab Results',
                          onChanged: (value) {
                            setState(() {
                              _lab_results = value;
                            });
                          },
                        ),
                        CheckListItem(
                            value: _notes,
                            title: 'Notes',
                            onChanged: (value) {
                              setState(() {
                                _notes = value;
                              });
                            }),
                        CheckListItem(
                          value: _log_history,
                          title: 'Log history',
                          onChanged: (value) {
                            setState(() {
                              _log_history = value;
                            });
                          },
                        )
                      ]),
                )),
                SizedBox(
                  height: 20,
                ),
              ]))),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(
                left: sizer(true, 10, context),
                right: sizer(true, 10, context)),
            child: ButtonBlue(
              title: widget.buttonText,
              onPressed: () => widget.isRequest
                  ? requestMedicalData(
                      _vitals,
                      _admission_history,
                      _previous_consultant_notes,
                      _patient_info,
                      _patient_history,
                      _examination_history,
                      _diagnosis_history,
                      _prescription_history,
                      _investigation_history,
                      _lab_results,
                      _notes,
                      _log_history)
                  : shareMedicalData(
                      _vitals,
                      _admission_history,
                      _previous_consultant_notes,
                      _patient_info,
                      _patient_history,
                      _examination_history,
                      _diagnosis_history,
                      _prescription_history,
                      _investigation_history,
                      _lab_results,
                      _notes,
                      _log_history),
            )),
      ),
    );
  }
}
