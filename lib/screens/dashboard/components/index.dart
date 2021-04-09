import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/models/digest.dart';
import 'package:thcMobile/screens/dashboard/subscribeToPlan/subscribeToPlan.dart';
import 'home.dart';
import '../messages.dart';
import 'vitals.dart';
import '../../../provider/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;

class DashboardBody extends StatefulWidget {
  DashboardBody({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  String firebaseId;
  bool newNotifications = false;
  bool newMessages = false;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<IconWidget> icons = [
    IconWidget(title: 'Doctors', image: 'assets/images/doctorIcon.png'),
    IconWidget(
        title: 'Appointments', image: 'assets/images/appointmentsIcon.png'),
    IconWidget(
        title: 'Test results', image: 'assets/images/testResultsIcon.png'),
    IconWidget(title: 'Medhub', image: 'assets/images/medhubIcon.png'),
    IconWidget(title: 'Medication', image: 'assets/images/medication.png'),
    IconWidget(title: 'Health Plans', image: 'assets/images/healthPlans.png'),
  ];
  List<DigestData> digests = [
    DigestData(
        title: 'Keeping fit in these COVID-19 times.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
  ];
  String currentTab = 'notifications';
  String name;
  @override
  void initState() {
    super.initState();
    // registerNotification();
    configLocalNotification();
  }

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      Platform.isAndroid
          ? showNotification(message['notification'])
          : showNotification(message['aps']['alert']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseId)
          .update({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning,';
    }
    if (hour < 17) {
      return 'afternoon,';
    }
    return 'evening,';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Color(0xff071232),
              padding: EdgeInsets.only(
                  top: 30,
                  bottom: 25,
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/images/sun.png',
                          width: 28, height: 28),
                      SizedBox(height: 5),
                      WhiteHeaderText(title: 'Good ' + greeting()),
                      SizedBox(height: sizer(false, 7, context)),
                      Text(Provider.of<UserModel>(context, listen: true).name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 28)),
                    ],
                  ),
                  Material(
                    color: Color(0xffff6f4f),
                    borderRadius: BorderRadius.circular(30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SubscribeToPlan()),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Image.asset(
                              'assets/images/notificationIcon.png',
                              width: 20,
                              height: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffF3F4F8),
              ),
              padding: EdgeInsets.only(
                  top: 20,
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  currentTab == 'notifications'
                      ? Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'notifications';
                                });
                            },
                            child: activeTab('Notifications', newNotifications),
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'notifications';
                                });
                            },
                            child:
                                inactiveTab('Notifications', newNotifications),
                          ),
                        ),
                  currentTab == 'messages'
                      ? Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'messages';
                                });
                            },
                            child: activeTab('Messages', newMessages),
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'messages';
                                });
                            },
                            child: inactiveTab('Messages', newMessages),
                          ),
                        ),
                  currentTab == 'vitals'
                      ? Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'vitals';
                                });
                            },
                            child: activeTab('Vitals', false),
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  currentTab = 'vitals';
                                });
                            },
                            child: inactiveTab('Vitals', false),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(height: 21),
            currentTab == 'notifications' ? Home() : Container(),
            currentTab == 'messages' ? Messages() : Container(),
            currentTab == 'vitals' ? Vitals() : Container(),
          ],
        ),
      ),
    );
  }

  Widget activeTab(String tabName, [bool unread]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tabName,
              style: TextStyle(
                color: blue,
                fontSize: sizer(true, 16.0, context),
              ),
            ),
            tabName != 'vitals'
                ? unread
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox()
                : SizedBox(),
            tabName != 'vitals'
                ? unread
                    ? Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    : SizedBox()
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: sizer(false, 15, context),
        ),
        Container(
          width: 90,
          height: 3,
          decoration: BoxDecoration(
            color: Color(0xff071232),
          ),
        ),
      ],
    );
  }

  Widget inactiveTab(String tabName, [bool unread]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tabName,
              style: TextStyle(
                color: darkBlue,
                fontSize: sizer(true, 16.0, context),
              ),
            ),
            tabName != 'vitals'
                ? unread
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox()
                : SizedBox(),
            tabName != 'vitals'
                ? unread
                    ? Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    : SizedBox()
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: sizer(false, 15, context),
        ),
        Container(
          width: 39,
          height: 3,
          decoration: BoxDecoration(color: Colors.transparent),
        )
      ],
    );
  }
}

class IconWidget {
  String title;
  String image;
  IconWidget({@required this.title, @required this.image});
}
