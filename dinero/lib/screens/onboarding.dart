import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/auth/authHandler.dart';
import 'package:dinero/widgets/selections.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: null,
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Image.asset("assets/images/dinero.png", fit: BoxFit.fitHeight),
          ),
          Container(
            height: 1,
            color: defaultGrey,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: defaultBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "WELCOME",
                  style: TextStyle(
                    color: defaultGreen,
                    fontSize: massiveText,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Selections(
                    route: Login(
                      isCustomer: true,
                    ),
                    title: "Customer",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Selections(
                    route: Login(
                      isCustomer: false,
                    ),
                    title: "Vendor",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
