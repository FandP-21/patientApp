import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:http/http.dart' as http;
import 'package:thcMobile/screens/auth/addPhoto.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/provider/user.dart';

class VerifyEnterOtpBody extends StatefulWidget {
  VerifyEnterOtpBody(
      {Key key, this.isLogin, this.scaffoldKey, @required this.firstName})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String firstName;
  final bool isLogin;

  @override
  _VerifyEnterOtpBodyState createState() => _VerifyEnterOtpBodyState();
}

class _VerifyEnterOtpBodyState extends State<VerifyEnterOtpBody> {
  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  String smsOTP;
  bool isLoading = false;
  bool isLoggedIn = false;
  User currentUser;
  String _buttonText = "PROCEED";

  @override
  void initState() {
    super.initState();
  }

  Future<Null> handleSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('firebaseId', currentUser.uid);
        await http.patch("https://thc2020.herokuapp.com/patient-list/$id/",
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            },
            body: {
              "firebase_id": currentUser.uid
            });
        print("UID: " + currentUser.uid);
      } else {
        // Write data to local
        await prefs.setString('firebaseId', documents[0].data()['id']);
        await http.patch("https://thc2020.herokuapp.com/patient-list/$id/",
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            },
            body: {
              "firebase_id": documents[0].data()['id']
            });
        print("Document: " + documents[0].data()['id']);
      }
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddPhoto(name: widget.firstName)));
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      this.setState(() {
        isLoading = false;
        _buttonText = "RETRY";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 100, context), left: 20, right: 20),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/brownHand.png',
                            width: 28,
                            height: 28,
                          ),
                          Spacer(
                            flex: 1,
                          )
                        ],
                      ),
                      SizedBox(height: sizer(false, 15, context)),
                      HeaderText(title: 'Hi, ' + widget.firstName),
                      SizedBox(height: sizer(false, 7, context)),
                      Text('Please verify your account',
                          style: TextStyle(
                              color: Color(0xff071232), fontSize: 28)),
                      SizedBox(height: sizer(false, 41, context)),
                      // SubText(
                      //   title:
                      //       'Enter the 6-digit OTP code sent to your phone number to verify your account',
                      //   isCenter: false,
                      // ),
                      SubText(
                        title:
                            'We need to verify your email by connecting your google account, this process is compulsory to ensure some features of the app. \n Click proceed to continue.',
                        isCenter: true,
                      ),
                      SizedBox(height: sizer(false, 100, context)),
                      // new Form(
                      //   key: _formKey,
                      //   autovalidate: _autoValidate,
                      //   child: customForm(),
                      // )
                      ButtonBlue(onPressed: handleSignIn, title: _buttonText),
                    ]))));
  }
}
