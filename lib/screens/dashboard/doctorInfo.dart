import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/buttonGreen.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/components/moreButton.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/services/base.dart';
import 'package:thcMobile/services/voiceCall.dart';
import 'package:thcMobile/utils/VideoCallUtils.dart';
import 'package:thcMobile/utils/call_utilities.dart';
import 'package:thcMobile/utils/permissions.dart';
import 'components/accountListItem.dart';
import 'shareMedicalData.dart';
import 'requestRefill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'scheduleAppointment.dart';
import 'doctorRate.dart';
import './actions/homeService/index.dart';

class DoctorInfo extends StatefulWidget {
  DoctorInfo({
    Key key,
    this.title,
    @required this.myDoctor,
    @required this.doctor,
    @required this.hasSubscribed,
    @required this.myId,
    @required this.myAvatar,
    @required this.myName,
  }) : super(key: key);
  final String title;
  final Doctor doctor;
  final bool myDoctor, hasSubscribed;
  final String myId;
  final String myAvatar, myName;
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  bool loading = false;
  bool isRegUnderHospital = false;
  String deviceToken = '';
  @override
  void initState() {
    super.initState();
    checkSubscription();
    getData();
  }

  Future<dynamic> getData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.doctor.user.id.toString())
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      if (snapshot.data() != null) {
        if (mounted)
          setState(() {
            deviceToken = snapshot.data()['deviceToken'];
          });
      } else {
        if (mounted)
          setState(() {
            deviceToken = '';
          });
      }
    });
  }

  Future<Null> reportDoctor() async {
    String id = Provider.of<UserModel>(context, listen: false).id;
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response = http.post(url + "report-doctor/", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "patient": id.toString(),
      "doctor": widget.doctor.id.toString(),
    });
  }

  Future<Null> handleBookingEnquiry() {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    var response = http.post(url + "book-doctor-request/", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "patient": id.toString(),
      "doctor": widget.doctor.id.toString(),
    });
    Fluttertoast.showToast(msg: 'Successful!');
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    return null;
  }

  void handleSubscription() {}
  void handleRateDoctor() {}
  Future removeDoctor() {}
  void checkSubscription() {
    String id = Provider.of<UserModel>(context, listen: false).id;
    for (int i = 0; i < widget.doctor.hospital.patients.length; i++) {
      if (widget.doctor.hospital.patients[i] == int.parse(id))
        setState(() => isRegUnderHospital = true);
    }
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
          height: MediaQuery.of(context).size.height * 0.89,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                HeaderText(title: 'Actions'),
                SizedBox(height: 28),
                AccountListItem(
                    last: false,
                    title: 'Send Message',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => Chat(
                                doctor: widget.doctor,
                                peerName: widget.doctor.user.name,
                                peerId: widget.doctor.firebaseId,
                                myAvatar: widget.myAvatar,
                                peerAvatar: widget.doctor.photo.toString(),
                                myName: Provider.of<UserModel>(context,
                                        listen: false)
                                    .name)),
                      );
                    }),
                AccountListItem(
                    last: false,
                    title: 'Request a prescription refill',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RequestRefill()),
                      );
                    }),
                AccountListItem(
                    last: false,
                    title: 'Share Medical Data',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ShareMedicalData(
                                  doctor: widget.doctor,
                                )),
                      );
                    }),
                AccountListItem(
                    last: false,
                    title: 'Schedule appointment',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ScheduleAppointment(
                                isSession: false,
                                doctorId: widget.doctor.id,
                                doctorName: widget.doctor.user.name,
                                hospitalId: widget.doctor.hospital.id)),
                      );
                    }),
                AccountListItem(
                    last: false,
                    title: 'Request home service',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => HomeServiceRequest(
                                  doctor: widget.doctor,
                                )),
                      );
                    }),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                ),
                                child: AlertDialog(
                                  title: Center(
                                    child: Text(
                                      "Are you sure you want to remove this doctor?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  content: Container(
                                    child: Text(
                                      "Ensure to check and verify before you remove.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "CANCEL",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => removeDoctor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "CONFIRM",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: sizer(false, 4, context)),
                        padding:
                            EdgeInsets.only(bottom: sizer(false, 4, context)),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffF3F4F8), width: 1.0))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Remove Doctor',
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontSize: sizer(true, 16.0, context))),
                            Material(
                              color: Color(0xffF3F4F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF3F4F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                      child: Icon(Icons.delete,
                                          size: 17, color: Colors.red)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AccountListItem(
                    last: false,
                    title: 'Rate  Doctor',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => DoctorRate(
                                  isPharmacy: false,
                                  pharmacy: null,
                                  isHospital: false,
                                  hospital: null,
                                  doctor: widget.doctor,
                                )),
                      );
                    }),
                AccountListItem(
                  last: false,
                  title: 'Report doctor',
                  onPressed: reportDoctor,
                ),
              ],
            ),
          ),
        );
      },
    );
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
                  top: sizer(false, 20, context),
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
                        onPressed: () => Navigator.pop(context),
                      ),
                      widget.myDoctor
                          ? widget.hasSubscribed
                              ? MoreButton(onPressed: () {
                                  displayBottomSheet(context);
                                })
                              : SizedBox()
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 259,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(223, 232, 252, 1),
                              blurRadius: 1,
                              spreadRadius: 1),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(widget.doctor.photo.toString()),
                            fit: BoxFit.contain)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Color(0xff0B1B4A),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/chargeIcon.png',
                                      width: 24, height: 24),
                                  SizedBox(width: 3),
                                  Text(
                                      'NGN ' +
                                          widget.doctor.rate.toString() +
                                          '/hr',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                          )
                        ]),
                        widget.hasSubscribed
                            ? Container(
                                margin: EdgeInsets.only(top: 65),
                                height: 114,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                              color: Color(0xff2254D3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                                style: BorderStyle.solid,
                                              )),
                                          child: Icon(
                                            Icons.videocam,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        onTap: () async => await Permissions
                                                .cameraAndMicrophonePermissionsGranted()
                                            ? CallUtils.dial({
                                                "uid": FirebaseAuth
                                                    .instance.currentUser.uid,
                                                "name": widget.myName,
                                                "profilePhoto": widget.myAvatar,
                                              }, {
                                                "uid": widget.doctor.firebaseId,
                                                "name": widget.doctor.user.name,
                                                "profilePhoto":
                                                    widget.doctor.photo,
                                              }, context)
                                            : {

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //         JoinChannelVideo()))
                                        },
                                      ),
                                      GestureDetector(
                                          child: Container(
                                            height: 52,
                                            width: 52,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(
                                                  "assets/images/call.png"),
                                            ),
                                          ),
                                          onTap: () async {
                                            await Permission.microphone
                                                .request()
                                                .catchError((e) => print(e));
                                            await Permission
                                                    .microphone.status.isGranted
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VoiceCall(
                                                              myAvatar: widget
                                                                  .myAvatar,
                                                              myId: FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  .uid,
                                                              myName:
                                                                  widget.myName,
                                                              name: widget
                                                                  .doctor
                                                                  .user
                                                                  .name,
                                                              peerAvatar: widget
                                                                  .doctor.photo,
                                                              peerId: widget
                                                                  .doctor
                                                                  .firebaseId,
                                                            )))
                                                : {};
                                          })
                                    ]))
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Dr ' + widget.doctor.user.name,
                      style: TextStyle(
                        color: black,
                        fontWeight: bold,
                        fontSize: pixel24,
                      )),
                  SizedBox(height: 10),
                  SubText(
                    title: widget.doctor.areaOfSpecialization[0].name,
                    isCenter: false,
                  ),
                  SizedBox(height: 10),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/hospitalIcon.png',
                          width: 24,
                          height: 25,
                        ),
                        SizedBox(width: 10),
                        SubText(
                          title: '\n' + widget.doctor.hospital.bio ?? '',
                          isCenter: false,
                        )
                      ]),
                  SizedBox(height: 25),
                  SubText(
                    title: 'Languages spoken',
                    isCenter: false,
                  ),
                  SizedBox(height: 5),
                  Text(widget.doctor.languages ?? 'None',
                      style: TextStyle(
                        color: black,
                        fontSize: pixel18,
                        fontWeight: normal,
                      )),
                  SizedBox(height: 15),
                  widget.doctor.isIndependent == true ||
                          widget.doctor.isIndependent.toString() == "true" ||
                          isRegUnderHospital == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xff0B1B4A),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/chargeIcon.png',
                                        width: 24, height: 24),
                                    SizedBox(width: 3),
                                    Text(
                                        'NGN ' +
                                            widget.doctor.rate.toString() +
                                            '/hr',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xff0B1B4A),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/chargeIcon.png',
                                        width: 24, height: 24),
                                    SizedBox(width: 3),
                                    Text(
                                        'NGN ' +
                                            widget.doctor.rate.toString() +
                                            '/mn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xff0B1B4A),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/chargeIcon.png',
                                        width: 24, height: 24),
                                    SizedBox(width: 3),
                                    Text(
                                        'NGN ' +
                                            widget.doctor.rate.toString() +
                                            '/yr',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 20),
                  SubText(
                    title: 'Bio',
                    isCenter: false,
                  ),
                  Text(widget.doctor.bioInfoOnSpecialization.toString(),
                      style: TextStyle(
                        fontSize: sizer(true, 16.0, context),
                        fontWeight: FontWeight.w300,
                      )),
                  SizedBox(height: 25),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rating',
                            style: TextStyle(
                                fontSize: sizer(true, 16.0, context),
                                color: Color(0xff8E919C)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.doctor.rating.toString() +
                                " (" +
                                widget.doctor.numberOfRatings.toString() +
                                " rating${widget.doctor.numberOfRatings == 1 ? '' : 's'})",
                            style: TextStyle(
                                color: Color(0xff2254D3),
                                fontSize: pixel20,
                                fontWeight: normal),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Patients',
                            style: TextStyle(
                                fontSize: sizer(true, 16.0, context),
                                color: Color(0xff8E919C)),
                          ),
                          Text(
                            widget.doctor.hospital.patients.length.toString() +
                                ' patients',
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: pixel20,
                                fontWeight: normal),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  widget.myDoctor == false
                      ? ButtonBlue(
                          title: 'MAKE \tBOOKING \tENQUIRY',
                          onPressed: handleBookingEnquiry,
                        )
                      : SizedBox(),
                  widget.myDoctor
                      ? ButtonGreen(
                          title: widget.hasSubscribed
                              ? 'RENEW\t SUBSCRIPTION'
                              : 'SUBSCRIBE',
                          onPressed: handleSubscription,
                        )
                      : SizedBox(),
                  widget.hasSubscribed
                      ? SizedBox(
                          height: 15,
                        )
                      : SizedBox(),
                  widget.hasSubscribed
                      ? ButtonBlue(
                          title: "RATE \tDOCTOR",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorRate(
                                        isHospital: false,
                                        isPharmacy: false,
                                        pharmacy: null,
                                        doctor: widget.doctor,
                                        hospital: null,
                                      ))))
                      : SizedBox(),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
