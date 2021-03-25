import 'package:flutter/material.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/authUploadInput.dart';
import '../components/accountListItem.dart';
import './components/greenMeterBox.dart';
import 'enterInfoC.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EnterInfoB extends StatefulWidget {
  EnterInfoB(
      {Key key,
      @required this.title,
      @required this.hasPlan,
      @required this.hmoId,
      @required this.duration,
      @required this.sixMonthsPrice,
      @required this.oneYearPrice,
      @required this.identifier,
      @required this.hmoPlanId})
      : super(key: key);
  final String title;
  final bool hasPlan;
  final String hmoId;
  final String duration;
  final String hmoPlanId;
  final String sixMonthsPrice, oneYearPrice, identifier;

  @override
  _EnterInfoBState createState() => _EnterInfoBState();
}

class _EnterInfoBState extends State<EnterInfoB> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController address = new TextEditingController();
  bool _autoValidate = false;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  void handleNavigate() {
    if (address.text.isNotEmpty)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => EnterInfoC(
                title: widget.title,
                hasPlan: widget.hasPlan,
                hmoId: widget.hmoId,
                hmoPlanId: widget.hmoPlanId,
                duration: widget.duration,
                identifier: widget.identifier,
                oneYearPrice: widget.oneYearPrice,
                sixMonthsPrice: widget.sixMonthsPrice,
              )));
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("All fields are required!",
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ))));
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.78,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
                top: 50,
                bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  HeaderText(title: 'Select ID type'),
                  SizedBox(height: 28),
                  AccountListItem(
                      last: false,
                      title: 'National ID Card/NIN',
                      onPressed: pickImage),
                  AccountListItem(
                      last: false,
                      title: 'Driver\'s License',
                      onPressed: pickImage),
                ]),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 50, context),
                      left: sizer(true, 20, context),
                      right: sizer(true, 20, context)),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            BackButtonWhite(
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        HeaderText(title: widget.title),
                        SizedBox(
                          height: 8,
                        ),
                        SubText(
                            isCenter: false,
                            title:
                                'Fill in your information to complete yur registration'),
                        SizedBox(height: 50),
                        new Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: customForm(context),
                        ),
                      ]),
                )))));
  }

  Widget customForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthTextInput(
              controller: address,
              hintText: 'House/contact address',
              onChanged: (text) {}),
        ),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 5, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: DropdownWidget(
                    title: "State",
                    store: ["Rivers", "Kwara", "Akwa-Ibom"],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: DropdownWidget(
                    title: "Town",
                    store: ["Ilorin", "Ilesha", "Ibadan"],
                  ),
                ),
              ],
            )),
        Container(
          width: MediaQuery.of(context).size.width,
          child: DropdownWidget(
            title: "Preferred hospital location",
            store: ["Kano", "Kastina", "Kebbi"],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: DropdownWidget(
            title: "Preferred hospital",
            store: ["Total Health Care", "Lekki Hospital", "Lagoon Hospital"],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthUploadInput(
              hintText: _image == null
                  ? 'Upload ID card'
                  : Image.file(_image).toString(),
              onPressed: () {
                displayBottomSheet(
                  context,
                );
              }),
        ),
        SizedBox(
          height: 30,
        ),
        GreenMeterBox(position: 0.4),
        SizedBox(
          height: 30,
        ),
        ButtonBlue(onPressed: handleNavigate, title: 'NEXT'),
        SizedBox(height: sizer(false, 32, context)),
        SizedBox(height: 10)
      ],
    );
  }
}
