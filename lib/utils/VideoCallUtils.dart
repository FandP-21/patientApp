/*
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  RtcEngine _engine;
  String channelId = "";
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine?.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig("afb92b423b9747d28b015c3f1b40f215"));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine
        ?.joinChannel("006afb92b423b9747d28b015c3f1b40f215IACOwvPa74i/ilDyFmYEzn9hteCJpQ/hp5r5xC/5IiJ/VAx+f9gAAAAAEAC5X9YGbnBbYAEAAQBtcFtg",
        channelId, null, 123);
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
  }

  _switchCamera() {
    _engine?.switchCamera()?.then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    })?.catchError((err) {
      log('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Channel ID'),
                    onChanged: (text) {
                      setState(() {
                        channelId = text;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed:
                          isJoined ? this._leaveChannel : this._joinChannel,
                          child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                        ),
                      )
                    ],
                  ),
                  _renderVideo(),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      onPressed: this._switchCamera,
                      child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _renderVideo() {
    return Expanded(child: Stack(
      children: [
        RtcLocalView.SurfaceView(),
        if (remoteUid != null)
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                      (e) => GestureDetector(
                    onTap: (){
                      _switchRender();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      child: RtcRemoteView.SurfaceView(
                        uid: e,
                      ),
                    ),
                  ),
                )),
              ),
            ),
          )
      ],
    ));
  }
}*/
