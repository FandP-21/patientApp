import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/questionTextInput.dart';
import 'package:thcMobile/components/iconBox.dart';
import 'package:thcMobile/models/digest.dart';
import 'package:thcMobile/screens/dashboard/components/digestBox.dart';
import 'package:thcMobile/components/mediumText.dart';
import 'package:thcMobile/services/singling.dart';
import './doctor.dart';
import '../appointments/index.dart';
import '../medication/index.dart';
import '../medicalRecords/testResults.dart';
import '../medHub/index.dart';
import '../healthPlans/index.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Signaling _signaling;

  @override
  void initState() {
    super.initState();
  }
  // Future<void> _connect(BuildContext context) async {
  //   if (_signaling == null) {
  //
  //     //_Init Signaling
  //     _signaling = new Signaling(widget.server, widget.secret, widget.userName, widget.iceServer);
  //
  //     //_Create session
  //     final String sessionId = await _signaling.createWebRtcSession(sessionId: widget.sessionName);
  //     print('◤◢◤◢◤◢◤◢◤◢◤ sessionId: $sessionId  ◤◢◤◢◤◢◤◢◤◢◤ ');
  //
  //     //_Create_token
  //     final String token = await _signaling.createWebRtcToken(sessionId: sessionId);
  //     print('◤◢◤◢◤◢◤◢◤◢◤ token: $token  ◤◢◤◢◤◢◤◢◤◢◤ ');
  //
  //     //_Connect_socket //ADDED AWAIT
  //     await _signaling.connect(context);
  //
  //     _signaling.onStateChange = (SignalingState state) {
  //       print('_signaling.onStateChange: $state');
  //       switch (state) {
  //         case SignalingState.CallStateNew:
  //           break;
  //         case SignalingState.CallStateBye:
  //           break;
  //         default:
  //           break;
  //       }
  //     };
  //
  //     _signaling.onLocalStream = ((stream) {
  //       print('onLocalStream: ${stream.id}');
  //       _localRenderer.srcObject = stream;
  //     });
  //
  //     _signaling.onAddRemoteStream = ((stream) {
  //       print('onAddRemoteStream: ${stream.id}');
  //       _remoteRenderer.srcObject = stream;
  //     });
  //
  //     _signaling.onRemoveRemoteStream = ((stream) {
  //       print('onRemoveRemoteStream');
  //       _remoteRenderer.srcObject = null;
  //     });
  //   }
  // }


  List<IconWidget> icons = [
    IconWidget(
        title: 'Doctors',
        image: 'assets/images/doctorIcon.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => DoctorBody(title: '')))),
    IconWidget(
        title: 'Appointments',
        image: 'assets/images/appointmentsIcon.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Appointments(title: '')))),
    IconWidget(
        title: 'Test results',
        image: 'assets/images/testResultsIcon.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => TestResults(title: '')))),
    IconWidget(
        title: 'Medhub',
        image: 'assets/images/medhubIcon.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MedHub(title: '')))),
    IconWidget(
        title: 'Medication',
        image: 'assets/images/medication.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Medication(title: '')))),
    IconWidget(
        title: 'Health Plans',
        image: 'assets/images/healthPlans.png',
        onPressed: (context) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HealthPlans(title: '')))),
  ];
  List<DigestData> digests = [
    DigestData(
        title: 'Keeping fit in these COVID-19 times.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
    DigestData(
        title: '12 healthy foods for diabetic patients.',
        subText: 'We’ll send you notifications a...',
        image: 'assets/images/imageDigest.png',
        author: 'Web MD'),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: sizer(true, 20, context), right: sizer(true, 20, context)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              QuestionTextInput(
                hintText: 'How are you feeling today?',
                onChanged: (text) {},
              ),
              SizedBox(height: sizer(false, 15, context)),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff2254D3),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Container(
                    height: sizer(false, 132, context),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/adBackground.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Color(0xff1E4AB8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Adspace here',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizer(true, 18, context)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: sizer(false, 15, context)),
              new GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                padding: EdgeInsets.all(0),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: icons.map((IconWidget item) {
                  return IconBox(
                    title: item.title,
                    imageName: item.image,
                    onPressed: item.onPressed != null
                        ? () => item.onPressed(context)
                        : () {},
                  );
                }).toList(),
              ),
              SizedBox(height: sizer(false, 26, context)),
              MediumText(title: 'YOUR DAILY DIGEST'),
              SizedBox(height: sizer(false, 15, context)),
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 0),
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: digests.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new DigestBox(
                    digest: digests[index],
                    onPressed: () {},
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconWidget {
  String title;
  String image;
  Function onPressed;
  IconWidget({@required this.title, @required this.image, this.onPressed});
}
