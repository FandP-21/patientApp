import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/onboarding.dart';
import 'package:dinero/widgets/notificationItem.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: deepGreen,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    color: white,
                    fontSize: largeText + 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.power_settings_new,
                    color: white,
                    size: 24,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Onboarding())),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext ctxt, int index) => NotificationItem(
                      name: "Ekiti Ado-Kiti",
                      photo: "assets/icons/plumber.png",
                    )),
          )
        ],
      ),
    );
  }
}
