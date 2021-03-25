import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/auth/authHandler.dart';
import 'package:dinero/screens/catalog.dart';
import 'package:dinero/screens/extras/hire.dart';
import 'package:dinero/screens/extras/info.dart';
import 'package:dinero/screens/extras/profile.dart';
import 'package:dinero/screens/notifications.dart';
import 'package:dinero/screens/onboarding.dart';
import 'package:dinero/widgets/searchInput.dart';
import 'package:dinero/widgets/services.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({@required this.personality});
  final String personality;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _personality = widget.personality;
      screen = _personality == null
          ? ''
          : _personality == 'customer' ? 'hire' : 'notifications';
    });
  }

  List main = [
    [
      Hire(),
      Profile(),
      Info(),
    ],
    [
      Notifications(),
      Catalog(),
      Profile(),
      Info(),
    ]
  ];
  Widget _main;
  String _personality;
  String screen = 'hire';

  void _switchTab(String e, int i, int j) {
    setState(() {
      screen = e;
      _main = main[i][j];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: null,
      backgroundColor: _main != null && _main == main[1][3] || _main == main[0][2] ? defaultBlack : white,
      body: _personality == null
          ? SizedBox()
          : _personality == 'customer'
              ? _main ?? main[0][0]
              : _main ?? main[1][0],
      bottomNavigationBar: _personality == null
          ? SizedBox()
          : _personality == 'customer'
              ? Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: deepGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => _switchTab("hire", 0, 0),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'hire'
                                ? Icon(
                                    Icons.swap_horiz,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.swap_horiz,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                      GestureDetector(
                          onTap: () => _switchTab("profile", 0, 1),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'profile'
                                ? Icon(
                                    Icons.supervised_user_circle,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.supervised_user_circle,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                      GestureDetector(
                          onTap: () => _switchTab("info", 0, 2),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'info'
                                ? Icon(
                                    Icons.info_outline,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.info_outline,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                    ],
                  ),
                )
              : Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: deepGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => _switchTab("notifications", 1, 0),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'notifications'
                                ? Icon(
                                    Icons.notifications_none,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.notifications_none,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                      GestureDetector(
                          onTap: () => _switchTab("services", 1, 1),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'services'
                                ? Icon(
                                    Icons.swap_horiz,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.swap_horiz,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                      GestureDetector(
                          onTap: () => _switchTab("profile", 1, 2),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'profile'
                                ? Icon(
                                    Icons.supervised_user_circle,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.supervised_user_circle,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                      GestureDetector(
                          onTap: () => _switchTab("info", 1, 3),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: screen == 'info'
                                ? Icon(
                                    Icons.info_outline,
                                    size: 30,
                                    color: white,
                                  )
                                : Icon(
                                    Icons.info_outline,
                                    size: 30,
                                    color: defaultBlack,
                                  ),
                          )),
                    ],
                  ),
                ),
    ));
  }
}
