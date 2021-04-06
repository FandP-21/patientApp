import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:thcMobile/helpers/color.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/billing/paystack.dart';

import 'package:thcMobile/screens/loader.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/provider/user.dart';
import 'package:thcMobile/provider/user_provider.dart';
import 'package:thcMobile/provider/image_upload_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => new UserModel()),
    ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _saveDeviceToken();
  }

  void _serialiseAndNavigate(Map<String, dynamic> message, String id) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    var groupChatId = notificationData['groupChatId'];
    var deviceToken = notificationData['deviceToken'];
    var name = notificationData['name'];
    var peerId = notificationData['id'];
    if (view != null) {
      if (view == 'chat') {}
    }
  }

  void _saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('main_id') ?? '');
    if (id != '') {
      String fcmToken = await _fcm.getToken();
      if (fcmToken != null) {
        Provider.of<UserModel>(context, listen: false).setDeviceToken(fcmToken);
        var user = _db.collection('users').doc(id);
        await user.set({
          'deviceToken': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
          // optional
          'platform': Platform.operatingSystem
        }, SetOptions(merge: true));
      } else {}
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          _serialiseAndNavigate(message, id);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          _serialiseAndNavigate(message, id);
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff071232),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Total Health Care',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SofiaPro',
        unselectedWidgetColor: Colors.transparent,
      ),
      home: Loader(title: 'THC'),
    );
  }
}
