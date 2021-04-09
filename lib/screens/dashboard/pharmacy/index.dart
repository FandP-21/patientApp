import 'package:flutter/material.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/selectButton.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import './components/drugBox.dart';

class Pharmacyy extends StatefulWidget {
  Pharmacyy({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PharmacyyState createState() => _PharmacyyState();
}

class _PharmacyyState extends State<Pharmacyy> {
  @override
  void initState() {
    super.initState();
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
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 25, context),
                right: sizer(true, 25, context),
                top: 50,
                bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    HeaderText(title: 'Drug details'),
                    SizedBox(height: 28),
                    DrugBox(
                      amount: 'NGN 1,500',
                      source: 'Beecham group',
                      title: 'Amoxillin',
                      onPressed: () {},
                    ),
                    SelectButton(),
                    ButtonBlue(
                      title: 'BUY',
                      onPressed: () {},
                    )
                  ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 48, horizontal: 25),
                          decoration: BoxDecoration(
                            color: Color(0xff071232),
                          ),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                BackButtonBlack(
                                  onPressed: () {},
                                ),
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2A3450),
                                    borderRadius: BorderRadius.circular(55 / 2),
                                  ),
                                  child: Image.asset(
                                    'assets/images/pharmacyIcon.png',
                                    width: 55,
                                    height: 55,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 19),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                WhiteHeaderText(title: widget.title),
                                Icon(Icons.info,
                                    color: Color(0xff87869a),
                                    size: sizer(true, 16, context)),
                              ],
                            ),
                            SizedBox(height: 19),
                            SearchTextInput(
                              hintText: 'search',
                            ),
                          ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F4F8),
                          ),
                          padding: EdgeInsets.only(
                              top: 20,
                              left: sizer(true, 5, context),
                              right: sizer(true, 5, context)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              inactiveTab('Services'),
                              activeTab('Pain relievers'),
                              inactiveTab('Antibiotics'),
                              inactiveTab('Contraceptives'),
                              inactiveTab('Skin'),
                            ],
                          ),
                        ),
                        SizedBox(height: 19),
                        DrugBox(
                          amount: 'NGN 1,500',
                          source: 'Beecham group',
                          title: 'Amoxillin',
                          onPressed: () {
                            displayBottomSheet(context);
                          },
                        ),
                        DrugBox(
                          amount: 'NGN 1,500',
                          source: 'Beecham group',
                          title: 'Amoxillin',
                          onPressed: () {
                            displayBottomSheet(context);
                          },
                        ),
                        DrugBox(
                          amount: 'NGN 1,500',
                          source: 'Beecham group',
                          title: 'Amoxillin',
                          onPressed: () {
                            displayBottomSheet(context);
                          },
                        ),
                        DrugBox(
                          amount: 'NGN 1,500',
                          source: 'Beecham group',
                          title: 'Amoxillin',
                          onPressed: () {
                            displayBottomSheet(context);
                          },
                        )
                      ]),
                ))));
  }

  Widget activeTab(String tabName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(tabName,
            style: TextStyle(
                color: Color(0xff2254D3),
                fontSize: sizer(true, 16.0, context))),
        SizedBox(height: sizer(false, 15, context)),
        Container(
          width: 39,
          height: 3,
          decoration: BoxDecoration(
            color: Color(0xff071232),
          ),
        )
      ],
    );
  }

  Widget inactiveTab(String tabName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(tabName,
            style: TextStyle(
                color: Color(0xff071232),
                fontSize: sizer(true, 16.0, context))),
        SizedBox(height: sizer(false, 15, context)),
        Container(
          width: 39,
          height: 3,
          decoration: BoxDecoration(color: Colors.transparent),
        )
      ],
    );
  }
}
