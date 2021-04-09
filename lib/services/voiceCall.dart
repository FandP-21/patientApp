import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thcMobile/screens/callscreens/call_screen_openvidu.dart';
import 'package:thcMobile/utils/call_utilities.dart';
import 'package:thcMobile/utils/permissions.dart';

class VoiceCall extends StatefulWidget {
  VoiceCall(
      {@required this.peerId,
      @required this.myId,
      @required this.name,
      @required this.myName,
      @required this.myAvatar,
      @required this.peerAvatar});
  final String peerId, myId, myAvatar, peerAvatar, name, myName;

  @override
  _VoiceCallState createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  bool muted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: Image.network(
                        widget.myAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: Image.network(
                        widget.peerAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ])),
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 0.7,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Ringing...",
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        onPressed: _onToggleMute,
                        child: Icon(
                          muted ? Icons.mic : Icons.mic_off,
                          color: muted ? Colors.white : Colors.blueAccent,
                          size: 20.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: muted ? Colors.blueAccent : Colors.white,
                        padding: const EdgeInsets.all(12.0),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child:
                              Icon(Icons.phone, size: 25, color: Colors.white),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.videocam,
                              size: 25, color: Color(0xff2254D3)),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                          // Future.delayed(
                          //   Duration(seconds: 1),
                          //   () async => await Permissions
                          //           .cameraAndMicrophonePermissionsGranted()
                          //       ? CallUtils.dial({
                          //           "uid":
                          //               FirebaseAuth.instance.currentUser.uid,
                          //           // "uid": "Hd6steBvdwQwVMAfyIa31dM8F3O2",
                          //           "name": widget.myName,
                          //           "profilePhoto": widget.myAvatar,
                          //         }, {
                          //     "uid": FirebaseAuth.instance.currentUser.uid.toString() == "xJhg1Ik80aQKW4f9SOkwJ27eBC63"?"bymymer4uWTlE3w3Onh8kidP2Fo1":"xJhg1Ik80aQKW4f9SOkwJ27eBC63",
                          //     // "uid": widget.peerId,
                          //           // uid: "n23Ge8CKhXgL8TUpZXKZbdWTLzM2",
                          //           "name": widget.name,
                          //           "profilePhoto": widget.peerAvatar,
                          //         }, context)
                          //       : {},
                          // );
                          print(widget.myId+widget.peerId);
                          print("dsfasd");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoCallOpen(userName:widget.myName,sessionName: widget.myId+widget.peerId,
                                    server: 'demos.openvidu.io:443',
                                    secret: /*'2d6c828e-5c29-4072-a8ab-f72aea58d8e8'*/'MY_SECRET',iceServer: 'stun.l.google.com:19302',
                                  )));
                        },
                      ),
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    // AgoraRtcEngine.muteLocalAudioStream(muted);
  }
}
