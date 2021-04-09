import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcMobile/provider/user.dart';
import './components/registerSuccess.dart';

class AddPhoto extends StatefulWidget {
  AddPhoto({Key key, this.title, this.name, this.id, this.token})
      : super(key: key);
  final String title;
  final String name;
  final String id;
  final String token;

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File _image;
  final picker = ImagePicker();
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    String token = widget.token;
    String id = widget.id;
    print(id);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String path = pickedFile.path;
    var filename = path.split('/').last;

    if (mounted)
      setState(() {
        _image = File(pickedFile.path);
      });
    var responseJson;
    Response response;
    Dio dio = new Dio();
    FormData data = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        path,
        filename: filename,
      ),
    });
    response = await dio
        .patch(
      Provider.of<UserModel>(context, listen: false).baseUrl +
          "patient-list/" +
          id +
          '/',
      data: data,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          }),
    )
        .catchError((e) {
      if (mounted)
        setState(() {
          loading = false;
        });
      print(e.response.data);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
      } else {
        message = e.response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    });
    if (mounted)
      setState(() {
        loading = false;
      });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['details'] != null) {
        message = response.data['details'];
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    }
    return print(responseJson);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff071232),
        body: LoadingOverlay(
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 50, context),
                        bottom: sizer(false, 34, context),
                        left: sizer(true, 20, context),
                        right: sizer(true, 20, context)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        vertical(5, true, context),
                        Text(
                          'Hi ' + widget.name + ',',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                    _image != null
                                        ? _image.path
                                        : 'assets/images/addImageIcon.png',
                                    fit: BoxFit.cover,
                                    width: 185,
                                    height: 185)),
                          ),
                          onTap: getImage,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // vertical(5, true, context),
                              Text('Now, add a photo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: pixel20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: sizer(false, 23, context)),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'This will help health professionals identify you faster',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: pixel16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                        vertical(20, true, context),
                        ButtonWhite(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => RegisterSuccess()),
                              );
                            },
                            title: _image == null ? 'SKIP FOR NOW' : 'NEXT'),
                      ],
                    ))),
            isLoading: loading));
  }
}
