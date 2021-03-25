import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'components/index.dart';
import 'account.dart';
import 'forums/index.dart';
import 'actions/index.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title, @required this.loading}) : super(key: key);
  final String title;
  final bool loading;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  bool _loading = false;

  final List<Widget> _children = [
    DashboardBody(),
    ForumIndex(),
    ActionsIndex(),
    Account(),
  ];
  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    if (mounted)
      setState(() {
        _currentIndex = index;
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        key: _scaffoldKey,
        body: _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true, // new
          items: [
            new BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? new Image.asset('assets/images/homeBlue.png',
                      width: 24, height: 24, fit: BoxFit.contain)
                  : new Image.asset('assets/images/homeGrey.png',
                      width: 24, height: 24, fit: BoxFit.contain),
              title: Text('Home',
                  style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
            ),
            new BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? new Image.asset('assets/images/forumsBlue.png',
                      width: 24, height: 24, fit: BoxFit.contain)
                  : new Image.asset('assets/images/forumsGrey.png',
                      width: 24, height: 24, fit: BoxFit.contain),
              title: Text('Forums',
                  style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
            ),
            new BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? new Image.asset('assets/images/actionsBlue.png',
                      width: 24, height: 24, fit: BoxFit.contain)
                  : new Image.asset('assets/images/actionsGrey.png',
                      width: 24, height: 24, fit: BoxFit.contain),
              title: Text('Actions',
                  style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
            ),
            new BottomNavigationBarItem(
              icon: _currentIndex == 3
                  ? new Image.asset('assets/images/accountBlue.png',
                      width: 24, height: 24, fit: BoxFit.contain)
                  : new Image.asset('assets/images/accountGrey.png',
                      width: 24, height: 24, fit: BoxFit.contain),
              title: Text('Account',
                  style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
            ),
          ],
        ),
      ),
    ));
  }
}
