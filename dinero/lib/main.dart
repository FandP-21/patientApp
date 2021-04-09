import 'dart:async';
import 'package:dinero/helpers/color.dart';
import 'package:dinero/helpers/main.dart';
import 'package:dinero/provider/appState.dart';
import 'package:dinero/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => new AppState()),
  ], child: MyApp()));
}

String url = 'http://dinerobackend.herokuapp.com/';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: deepGreen,
    ));
    return MaterialApp(
      title: 'Impulse',
      theme: ThemeData(
        accentColor: deepGreen,
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: white,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  Duration seconds = Duration(seconds: 5);
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Onboarding())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: null,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child:
                Image.asset("assets/images/dinero.png", fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );
  }
}
