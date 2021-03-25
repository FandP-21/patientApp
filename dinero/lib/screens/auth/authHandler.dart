import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/auth/isCustomer.dart';
import 'package:dinero/screens/auth/isVendor.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Login extends StatefulWidget {
  Login({this.isCustomer});
  final bool isCustomer;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String screen = 'login';
  bool extend = false;
  String authMethod = '--- Choose to select ---';
  bool selected = false;
  bool loading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        backgroundColor: deepGreen));
  }

  void isLoading() {
    if (loading == true)
      setState(() => loading = false);
    else
      setState(() => loading = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      appBar: null,
      body: LoadingOverlay(
        color: deepGreen,
        opacity: 0.2,
        isLoading: loading,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border(
                              bottom: BorderSide(
                            color: screen == 'login' ? defaultBlack : white,
                            width: 5,
                            style: BorderStyle.solid,
                          ))),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color:
                              screen == "login" ? defaultGreen : defaultBlack,
                        ),
                      ),
                    ),
                    onTap: () => setState(() => screen = "login"),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border(
                              bottom: BorderSide(
                            color: screen == 'signup' ? defaultBlack : white,
                            width: 5,
                            style: BorderStyle.solid,
                          ))),
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
                          color:
                              screen == "signup" ? defaultGreen : defaultBlack,
                        ),
                      ),
                    ),
                    onTap: () => setState(() => screen = "signup"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: defaultBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: widget.isCustomer
                  ? IsCustomer(
                      screen: screen,
                      callback: showSnackbar,
                      loading: isLoading)
                  : IsVendor(
                      screen: screen,
                      callback: showSnackbar,
                      loading: isLoading),
            )
          ],
        )),
      ),
    ));
  }
}
