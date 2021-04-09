import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:thcMobile/services/base.dart';
import 'package:thcMobile/utils/call_utilities.dart';

class VitalsUpdate extends StatefulWidget {
  VitalsUpdate(
      {Key key,
      this.title,
      @required this.bmi,
      @required this.bp,
      @required this.weight,
      @required this.height,
      @required this.bloodOxygen,
      @required this.pulse,
      @required this.updateState,
      @required this.temperature})
      : super(key: key);
  final String title;
  final String bmi;
  final String bp;
  final String weight;
  final String height;
  final String bloodOxygen;
  final String pulse;
  final String temperature;
  final VoidCallback updateState;

  @override
  _VitalsUpdateState createState() => _VitalsUpdateState();
}

class _VitalsUpdateState extends State<VitalsUpdate> {
  TextEditingController bpController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bloodOxygenController = TextEditingController();
  TextEditingController pulseController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###/###', filter: {"#": RegExp(r'[0-9]')});
  String bmi;
  String weight;
  String height;
  String bloodOxygen;
  String pulse;
  String temperature;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future postData() async {
    _formKey.currentState.save();
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
    _setHistory(pulse, bloodOxygen);
    Map<String, dynamic> data = {
      "bmi": bmi != '' ? bpController.text : null,
      "bp": maskFormatter.getMaskedText() != ''
          ? maskFormatter.getMaskedText()
          : null,
      "weight": weight != '' ? weightController.text : null,
      "height": height != '' ? heightController.text : null,
      "blood_oxygen": bloodOxygen != '' ? bloodOxygenController.text : null,
      "pulse": pulse != '' ? pulseController.text : null,
      "temperature": temperature != '' ? tempController.text : null,
    };
    print("\n\n\n$data\n\n\n");
    response = await dio
        .patch(
      url + "patient-list/" + id + '/',
      data: data,
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
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
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
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    } else {
      widget.updateState();
      return Navigator.pop(context);
    }
  }

  pad(int n) {
    if (n < 10)
      return ("0" + n.toString());
    else
      return n.toString();
  }

  void _setHistory(pulse, spo2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      "time": "${pad(DateTime.now().hour)}:${pad(DateTime.now().minute)}",
      "date":
          "${DateTime.now().day} ${months[DateTime.now().month - 1]}, ${DateTime.now().year}",
      "bp": maskFormatter.getMaskedText() != ''
          ? maskFormatter.getMaskedText()
          : 'N/A',
      "pulse": pulse != '' ? pulse : 'N/A',
      "bloodOxygen": spo2 != '' ? spo2 : 'N/A',
    };

    List _history = jsonDecode(prefs.getString("vitalsHistoryData")) ?? [];
    _history.add(data);

    prefs.setString("vitalsHistoryData", jsonEncode(_history));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: sizer(false, 100, context),
                              left: sizer(true, 20, context),
                              right: sizer(true, 20, context)),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    BackButtonWhite(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(height: sizer(false, 15, context)),
                                HeaderText(title: 'Update Vitals'),
                                SizedBox(height: sizer(false, 38, context)),
                                new Form(
                                  key: _formKey,
                                  child: customForm(),
                                )
                              ]))))),
          isLoading: loading,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput(
              (text) {}, 'BP', widget.bp, "mm/Hg", true, true, bpController),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput((text) {
            if (mounted)
              setState(() {
                weight = text;
              });
          }, 'Weight', widget.weight, "Kg", true, false, weightController),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput((text) {
            if (mounted)
              setState(() {
                height = text;
              });
          }, 'Height', widget.height, "cm", true, false, heightController),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput((text) {
            if (mounted)
              setState(() {
                bloodOxygen = text;
              });
          }, 'Blood Oxygen', widget.bloodOxygen, "%", true, false,
              bloodOxygenController),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput((text) {
            if (mounted)
              setState(() {
                pulse = text;
              });
          }, 'Pulse', widget.pulse, "bpm", true, false, pulseController),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: vitalsInput((text) {
            if (mounted)
              setState(() {
                temperature = text;
              });
          }, 'Temperature', widget.temperature, "DegC", true, false,
              tempController),
        ),
        ButtonBlue(
            onPressed: () {
              if (bpController.text.isEmpty) {
                FlutterToast.showToast('Please enter BP');
              } else if (weightController.text.isEmpty) {
                FlutterToast.showToast('Please enter Weight');
              } else if (heightController.text.isEmpty) {
                FlutterToast.showToast('Please enter Height');
              } else if (bloodOxygenController.text.isEmpty) {
                FlutterToast.showToast('Please enter Blood Oxygen');
              } else if (pulseController.text.isEmpty) {
                FlutterToast.showToast('Please enter Pulse');
              } else if (tempController.text.isEmpty) {
                FlutterToast.showToast('Please enter Temperature');
              } else {
                postData();
              }
            },
            title: 'UPDATE'),
        SizedBox(height: sizer(false, 32, context)),
        SizedBox(height: 10)
      ],
    );
  }

  Widget vitalsInput(Function onChanged, hintText, value, unit, bool hasUnit,
      [bool inputFormat, TextEditingController controller]) {
    return TextFormField(
      initialValue: value,
      keyboardType: TextInputType.phone,
      onSaved: onChanged,
      controller: controller,
      inputFormatters: inputFormat != null ? [maskFormatter] : [],
      style: TextStyle(
          color: Color(0xFF606983),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 16.0, context)),
      cursorColor: Color(0xff245DE8),
      decoration: InputDecoration(
        suffixIcon: Container(
          height: 45,
          padding: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.4,
          alignment: Alignment.centerRight,
          child: Text(
            hintText.toString() + '${hasUnit ? " ($unit)" : ""}',
            style: TextStyle(
              color: Color(0xff828A95),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: Color(0xffF3F4F8),
        hintText: hintText.toString(),
        hintStyle: TextStyle(
            color: Colors.transparent, fontSize: sizer(true, 16.0, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xff245DE8),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
      ),
    );
  }
}
