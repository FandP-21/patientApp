import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/request.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/skillsBox.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/screens/dashboard/doctorInfo.dart';

class RequestsWidget extends StatefulWidget {
  RequestsWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestsWidgetState createState() => _RequestsWidgetState();
}

class _RequestsWidgetState extends State<RequestsWidget> {
  List patientRequests = [];
  bool loading = false;
  var patientData;
  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("patientRequests")) {
      setState(() {
        loading = false;
        patientRequests = jsonDecode(prefs.getString("patientRequests"));
      });
      print(patientRequests);
    } else {
      setState(() {
        loading = true;
      });
    }
    this.fetchRequests();
  }

  void fetchRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    var pending = await http
        .get(url + "book-doctor-request/?patient=$id&status=pending", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    var accepted = await http.get(
        url + "book-doctor-request/?patient=$id&status=accepted",
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    var declined = await http.get(
        url + "book-doctor-request/?patient=$id&status=declined",
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    setState(() {
      patientRequests = [
        jsonDecode(pending.body),
        jsonDecode(accepted.body),
        jsonDecode(declined.body)
      ].expand((x) => x).toList();
      loading = false;
    });

    prefs.setString("patientRequests", jsonEncode(patientRequests));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: sizer(true, 20, context), right: sizer(true, 20, context)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                "${patientRequests.length} Request${patientRequests.length > 1 ? 's' : ''}",
                style: TextStyle(
                  color: Color(0xff071232),
                  fontSize: sizer(true, 24, context),
                ),
              ),
              SizedBox(height: 20),
              loading
                  ? SizedBox(
                      height: 25,
                    )
                  : SizedBox(),
              loading
                  ? CenterLoader()
                  : patientRequests.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: patientRequests.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return requestBox(
                                Request.fromJson(patientRequests[index]));
                          },
                        )
                      : EmptyData(
                          title: 'No requests presently', isButton: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestBox(Request request) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              request.doctor.photo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(22.5),
                      child: Image.network(request.doctor.photo,
                          fit: BoxFit.cover, width: 50, height: 50))
                  : Container(),
              SizedBox(width: sizer(true, 15, context)),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Dr " + request.doctor.user.name,
                      style: TextStyle(
                          color: Color(0xff071232),
                          fontWeight: FontWeight.w500,
                          fontSize: sizer(true, 16.0, context))),
                  SizedBox(height: 3),
                  Container(
                      child: Row(children: [
                    SizedBox(
                        height: 20,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              request.doctor.areaOfSpecialization.length > 2
                                  ? 2
                                  : request.doctor.areaOfSpecialization.length,
                          itemBuilder: (BuildContext context, int index) =>
                              SkillsBox(
                            title:
                                request.doctor.areaOfSpecialization[index].name,
                          ),
                        )),
                    request.doctor.areaOfSpecialization.length > 2
                        ? SkillsBox(
                            title: '+' +
                                (request.doctor.areaOfSpecialization.length - 2)
                                    .toString())
                        : SizedBox(),
                  ])),
                ],
              )),
              SizedBox(width: sizer(true, 15, context)),
              Material(
                //    color: Color(0xffF3F4F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: request.status == 'declined'
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          )),
                        )
                      : Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: request.status == "accepted"
                                ? sameGreen
                                : Color(0xffFF994F),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                              child: request.status != "accepted"
                                  ? Image.asset(
                                      "assets/images/requestsIcon.png",
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain)
                                  : Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                        ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => request.status == 'accepted'
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorInfo(
                        myId: null,
                        myAvatar: null,
                        myName: null,
                        myDoctor: true,
                        doctor: request.doctor,
                        hasSubscribed: false)))
            : {});
  }
}
