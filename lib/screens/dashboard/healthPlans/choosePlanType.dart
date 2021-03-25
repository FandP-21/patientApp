import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/components/multiInput.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'enterInfoA.dart';

class ChoosePlanType extends StatefulWidget {
  ChoosePlanType(
      {Key key,
      @required this.title,
      @required this.monthly,
      @required this.description,
      @required this.hmoId,
      @required this.hmoPlanId,
      @required this.identifier,
      @required this.yearly})
      : super(key: key);
  final String title;
  final String monthly, yearly;
  final String description, identifier;
  final int hmoId, hmoPlanId;

  @override
  _ChoosePlanTypeState createState() => _ChoosePlanTypeState();
}

class _ChoosePlanTypeState extends State<ChoosePlanType> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String active = '';
  String _description = "";

  @override
  void initState() {
    super.initState();
  }

  void createSelection(String title, String description) {
    setState(() => active = title);
    setState(() => _description = description);
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
          child: Padding(
            padding: EdgeInsets.only(
                top: sizer(false, 50, context),
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
                bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(height: sizer(false, 20, context)),
                HeaderText(title: widget.title),
                SizedBox(
                  height: 8,
                ),
                SubText(isCenter: false, title: 'Choose a plan type:'),
                SizedBox(height: sizer(false, 30, context)),
                Column(children: [
                  Container(
                      child: Material(
                          color: Color(0xffF3F4F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () => {},
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: active == '6'
                                      ? Color.fromRGBO(223, 232, 252, 1)
                                      : Color.fromRGBO(243, 244, 248, 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 24,
                                              width: 24,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: active == '6'
                                                      ? blue
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.grey[100],
                                                    width: 0.2,
                                                  )),
                                              child: Checkbox(
                                                  value: active == '6'
                                                      ? true
                                                      : false,
                                                  checkColor: Colors.white,
                                                  activeColor:
                                                      Color(0xff245DE8),
                                                  onChanged: (value) =>
                                                      createSelection('6',
                                                          widget.description))),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('6  months cover',
                                              style: TextStyle(
                                                  color: active == '6'
                                                      ? blue
                                                      : Colors.black,
                                                  fontSize:
                                                      sizer(true, 16, context),
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    Text("NGN " + '${widget.monthly}',
                                        style: TextStyle(
                                            color: Color(0xff071232),
                                            fontSize: sizer(true, 16, context),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )),
                          ))),
                  SizedBox(height: 10),
                  Container(
                      child: Material(
                          color: Color(0xffF3F4F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () => {},
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: active == '12'
                                      ? Color.fromRGBO(223, 232, 252, 1)
                                      : Color.fromRGBO(243, 244, 248, 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 24,
                                              width: 24,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: active == '12'
                                                      ? blue
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.grey[100],
                                                    width: 0.2,
                                                  )),
                                              child: Checkbox(
                                                  value: active == '12'
                                                      ? true
                                                      : false,
                                                  checkColor: Colors.white,
                                                  activeColor:
                                                      Color(0xff245DE8),
                                                  onChanged: (value) =>
                                                      createSelection('12',
                                                          widget.description))),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('1 year',
                                              style: TextStyle(
                                                  color: active == '12'
                                                      ? blue
                                                      : Colors.black,
                                                  fontSize:
                                                      sizer(true, 16, context),
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    Text("NGN " + '${widget.yearly}',
                                        style: TextStyle(
                                            color: Color(0xff071232),
                                            fontSize: sizer(true, 16, context),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )),
                          )))
                ]),
                SizedBox(height: 40),
                Text("Desription",
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 16, context),
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 15),
                MultiInput(
                  hintText: "Select plan to view description",
                  controller: TextEditingController(text: _description),
                  deepColor: Colors.black,
                  minLines: 5,
                  enabled: false,
                  maxLines: 5,
                ),
                SizedBox(height: 30),
                ButtonBlue(
                  title: 'NEXT',
                  onPressed: () {
                    active != ''
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => EnterInfoA(
                                      title: widget.title,
                                      hasPlan: false,
                                      hmoId: widget.hmoId.toString(),
                                      hmoPlanId: widget.hmoPlanId.toString(),
                                      duration: active,
                                      oneYearPrice: widget.yearly.toString(),
                                      sixMonthsPrice: widget.monthly.toString(),
                                      identifier: widget.identifier,
                                    )),
                          )
                        : _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Please select a plan",
                                style: TextStyle(
                                  fontSize: sizer(true, 15.0, context),
                                  color: Colors.white,
                                ))));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
