import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pubnub/pubnub.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pubnub/core.dart';
import 'package:pubnub/pubnub.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/messageInput.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/utils/utilities.dart';
import 'dart:io' as Io;
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';


class ForumChat extends StatefulWidget {
  ForumChat({@required this.title});
  final String title;

  @override
  _ForumChatState createState() => _ForumChatState();
}

class _ForumChatState extends State<ForumChat> {
  // final _firstUserClient = PubNub(PubNubConfig('pub-c-954e65a5-3aee-4aa2-9a9e-36d4d5aaad45', 'sub-c-dcb71ad0-8770-11eb-a47e-8aa5932e3236',
  //     uuid: 'a0a80f2d-b48d-460c-b3bd-a244a877df1f',filter: ''));
  var pubnub = PubNub(
      defaultKeyset:
      Keyset(subscribeKey: 'sub-c-dcb71ad0-8770-11eb-a47e-8aa5932e3236', publishKey: 'pub-c-954e65a5-3aee-4aa2-9a9e-36d4d5aaad45', uuid:
      UUID('a0a80f2d-b48d-460c-b3bd-a244a877df1f'),secretKey: 'sec-c-YTQzOTNkZGQtNWJkZi00NjUwLThiMjgtNGIxZTlhNGRmMTU3'));
  TextEditingController _inputController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  ScrollController _scrollController = ScrollController();
  var firebaseID = '';
  Future sendEvent(String eventName, String message) async {
    Dio dio = new Dio(); // with default Options

    // await dio.post("http://logs-01.loggly.com/inputs/<loggly_key>/tag/http",
    //     data: {"flutter_pubnub": eventName, "message": message});
  }
  List historyData = [];
  List copyListList = [];
  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = List<dynamic>();
      for (int i = 0; i < copyListList.length; i++) {
        if (copyListList[i]['message']['message']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(copyListList[i]);
        }
      }
      setState(() {
        historyData.clear();
        historyData.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        historyData.clear();
        historyData.addAll(copyListList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _firstUserClient.uuid().then((uuid) {
    //   print('UUID1: $uuid');
    //   sendEvent('UUID', uuid);
    // });
    // // _secondUserClient.uuid().then((uuid) => print('UUID2: $uuid'));
    // _firstUserClient.onStatusReceived.listen((status) {
    //   print('Status:${status.toString()}');
    //   sendEvent('STATUS', status.toString());
    // });
    // _firstUserClient.onPresenceReceived.listen((presence) {
    //   print('Presence:${presence.toString()}');
    //   sendEvent('PRESENCE', presence.toString());
    // });
    // _firstUserClient.onMessageReceived.listen((message) {
    //   print('Message:$message');
    //   sendEvent('MESSAGE', message.toString());
    // });
    //
    // _firstUserClient.onErrorReceived.listen((error) {
    //   print('Error:$error');
    //   sendEvent('ERROR', error.toString());
    // });

    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        sendEvent('PUSH MESSAGE', message.toString());
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    history();
    _scrollController.addListener(listScrollListner);
  }
  listScrollListner() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      debugPrint('reach the bottom');
    }
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      debugPrint('reach the top');
    }
  }
  history() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firebaseID = prefs.getString('firebaseId');
    historyData.clear();
    var history =  pubnub.channel('testafterSignal').messages();
    var historyDat = await history.fetch();
    historyData.addAll(historyDat.messages);
    copyListList.addAll(historyDat.messages);
    print("asdf");
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 1000000000000000000,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/forumBackground.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            vertical(25, false),
            Container(
                padding:EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 100),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: black,
                  fontSize: pixel28,
                  fontWeight: bold,
                ),
              ),
            ),
            vertical(20, false),
           Container(
             margin: EdgeInsets.only(top: 140),
             padding: EdgeInsets.symmetric(horizontal: 20),
      child:SearchTextInput(
        hintText: 'Search',
        onChanged: (value){
          filterSearchResults(value);
        },
      ),
           ),
            vertical(5, false),
            Container(
                margin: EdgeInsets.only(top: 230, bottom: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: historyData.length,
                            itemBuilder: (cttx,index){
                              return  historyData[index]['message']['image']== null?GestureDetector(
                                onTap: () async {
                                  var asfd = await pubnub.channel('testafterSignal').deleteMessageAction(Timetoken(historyData[index]['timetoken']), Timetoken.fromDateTime(DateTime.now()));
                                  var xyz = await pubnub.deleteMessageAction('testafterSignal',  Timetoken(historyData[index]['timetoken']), Timetoken.fromDateTime(DateTime.now()));
                                  print("adfa");
                                },
                                child: textMessage(
                                    historyData[index]['message']['name']!= null? historyData[index]['message']['name']:'',
                                    historyData[index]['message']['message']!= null? historyData[index]['message']['message']:'',
                                    historyData[index]['message']['time']!= null? historyData[index]['message']['time']:'',
                                    historyData[index]['message']['id']!= null? historyData[index]['message']['id']:'',
                                ),
                              ):Container(
                                height: 100,
                                width: 100,
                                child: Image.memory(base64Decode(historyData[index]['message']['image'])),
                              );
                            }),
                      ),
                    ),
                    sendMessageView()
                  ],
                )),
          ],
        ));
  }
  Widget sendMessageView(){
    return MessageInput(
        hintText: 'Enter a message',
        controller: _inputController,
        onMessagePressed: () async {
          if (_inputController.text.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String name = '${prefs.getString('name')} ${ prefs.getString(
                'Lname')}';
            var data = {'message': _inputController.text,
              'name': name,
              'id': prefs.getString('firebaseId'),
              'time': DateFormat('dd MMM, yyyy hh:mm a')
                  .format(DateTime.now())
                  .toString()
            };
            await pubnub.channel('testafterSignal').publish(data);
            Map ap = Map();
            ap['message'] = data;
            historyData.add(ap);
            setState(() {});
            _inputController.clear();
          }
        },
        onImagePressed: () async {
          var image = await Utils.pickImage(source: ImageSource.gallery);
          if (image!= null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String name = '${prefs.getString('name')} ${ prefs.getString(
                'Lname')}';
            final bytes = image.readAsBytesSync();
            String image1 = Base64Encoder().convert(bytes);
            var data = {'message': _inputController.text,
              'name': name,
              'id': prefs.getString('firebaseId'),
              'time': DateFormat('dd MMM, yyyy hh:mm a')
                  .format(DateTime.now())
                  .toString(),
              'image':image1
            };
            await pubnub.files.sendFile('testafterSignal', 'fileName', bytes);
             // _firstUserClient.publish(
             //    ['testafterSignal', ''], data).then((value){
             //      print("adfa");
             // });
          }
        },
        onMicPressed: (details) => {},
        onMicReleased: (details) => {},
        onCameraPressed: () async {
          var image = await Utils.pickImage(source: ImageSource.camera);
          if (image!= null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String name = '${prefs.getString('name')} ${ prefs.getString(
                'Lname')}';
            final bytes = image.readAsBytesSync();
            String image1 = Base64Encoder().convert(bytes);
            var data = {'message': _inputController.text,
              'name': name,
              'id': prefs.getString('firebaseId'),
              'time': DateFormat('dd MMM, yyyy hh:mm a')
                  .format(DateTime.now())
                  .toString(),
              'image':image1
            };
            // _firstUserClient.publish(
            //     ['testafterSignal', ''], data).then((value){
            //   print("adfa");
            // });
          }
        });
  }

  Widget textMessage(String name, String message, String timeAndDate,String id) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15,left: id ==firebaseID?100:0,right: id ==firebaseID?0:100),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    timeAndDate,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
            ],
          ),
          vertical(7, false),
          Container(
            alignment: id ==firebaseID?Alignment.topRight:Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blue.withOpacity(0.2),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 30, 30),
            child: Text(
              message,
              style: TextStyle(
                color: black,
                height: 1.5,
                fontSize: pixel14,
                fontWeight: normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageMessage(String name, String message, String timeAndDate,
      String image, String profilePhoto) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    timeAndDate,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
            ],
          ),
          vertical(7, false),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blue.withOpacity(0.2),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 30, 10),
            child: Column(children: [
              Text(
                message,
                style: TextStyle(
                  color: black,
                  height: 1.5,
                  fontSize: pixel14,
                  fontWeight: normal,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5),
                  Container(
                    height: 80,
                    width: 81,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                height: 80,
                                width: 70.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(image),
                                        fit: BoxFit.cover)))),
                        Container(
                          height: 9,
                          width: 9,
                          margin: EdgeInsets.only(top: 70),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              profilePhoto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}