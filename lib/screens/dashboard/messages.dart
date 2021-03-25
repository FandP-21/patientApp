import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/centerLoader.dart';
import 'package:thcMobile/models/doctor.dart';
import 'package:thcMobile/provider/user.dart';
import 'components/messageListItem.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/services/base.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  Messages({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String firebaseID;
  bool isLoading = false;
  String currentUser = '';

  @override
  void initState() {
    super.initState();
    this._setFirebaseID();
  }

  void _setFirebaseID() {
    setState(() => currentUser = FirebaseAuth.instance.currentUser.uid);
    print("\n\n\n\n\n\n\n$currentUser\n\n\n\n");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(
              left: sizer(true, 20, context), right: sizer(true, 20, context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SearchTextInput(
                hintText: 'Search',
                onChanged: (text) {},
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Contacts')
                      .doc(currentUser)
                      .collection("contacts")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CenterLoader();
                    } else {
                      try {
                        var key = snapshot.data.documents[0]["name"];
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) {
                            return MessageListItem(
                                name: snapshot.data.documents[index]["name"],
                                message:
                                    "${snapshot.data.documents[index]["name"]} sent a message",
                                time:
                                    "${snapshot.data.documents[index]["time"]}",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => Chat(
                                              myAvatar: "",
                                              myName: Provider.of<UserModel>(
                                                      context,
                                                      listen: false)
                                                  .name,
                                              peerName: snapshot.data
                                                  .documents[index]["name"],
                                              peerAvatar: 'https://thc2020.herokuapp.com/media/doctor_photo/process_3_t7oNy51.png',
                                              peerId: snapshot.data
                                                  .documents[index]["userId"],
                                            )),
                                  );
                                });
                          },
                          itemCount: snapshot.data.documents.length,
                        );
                      } on RangeError {
                        return EmptyData(
                            title: 'You don\'t have any messages presently',
                            isButton: false);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        )));
  }
}