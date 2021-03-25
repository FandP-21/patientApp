import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/moreButton.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/selectButton.dart';
import 'package:thcMobile/models/pharmacy.dart';
import 'package:thcMobile/screens/dashboard/pharmacy/pharmacyInfo.dart';

class DrugDetails extends StatefulWidget {
  DrugDetails({Key key, this.title, this.pharmacy, @required this.drug})
      : super(key: key);
  final String title;
  final Pharmacy pharmacy;
  final List drug;

  @override
  _DrugDetailsState createState() => _DrugDetailsState();
}

class _DrugDetailsState extends State<DrugDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              onPressed: () => Navigator.pop(context),
                            ),
                            MoreButton(onPressed: () {})
                          ],
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Drug details'),
                        SizedBox(height: 35),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.drug.length,
                            itemBuilder: (BuildContext context, int index) =>
                                drugPanel(DrugWidget(
                                    title: widget.drug[index]['name'],
                                    location: "Beecham group",
                                    amount: widget.drug[index]['price']))),
                        SizedBox(height: 10),
                        SelectButton(),
                        SizedBox(height: 10),
                        ButtonBlue(
                          title: 'BUY',
                          onPressed: () {},
                        ),
                        SizedBox(height: 43),
                        GestureDetector(
                          child: Container(
                              child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(27.5),
                                  child: Image.asset(
                                      'assets/images/pharmacyIcon.png',
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.contain)),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Sold by',
                                      style: TextStyle(
                                          color: Color(0xff8E919C),
                                          fontSize:
                                              sizer(true, 16.0, context))),
                                  Text(widget.pharmacy.user.username,
                                      style: TextStyle(
                                          color: Color(0xff071232),
                                          fontSize: sizer(true, 20, context))),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Color(0xffDFE8FC)),
                                  child: Icon(Icons.arrow_forward,
                                      color: Color(0xff245DE8), size: 18))
                            ],
                          )),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PharmacyInfo(
                                        title: '',
                                        pharmacy: widget.pharmacy,
                                      ))),
                        ),
                      ]),
                )))));
  }

  Widget drugPanel(DrugWidget drug) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/drugImage.png',
                  width: 55, height: 55, fit: BoxFit.contain)),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(drug.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Text(drug.location,
                  style: TextStyle(
                      color: Color(0xff8E919C),
                      fontSize: sizer(true, 16.0, context))),
            ],
          )),
          Spacer(),
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 14.6),
            decoration: BoxDecoration(
              color: Color(0xffDFE8FC),
              borderRadius: BorderRadius.circular(14.6),
            ),
            child: Center(
                child: Text(drug.amount.toString(),
                    style: TextStyle(
                        color: Color(0xff2254D3),
                        fontSize: sizer(true, 14, context)))),
          )
        ],
      ),
    );
  }
}

class DrugWidget {
  String title;
  String location;
  double amount;
  DrugWidget(
      {@required this.title, @required this.location, @required this.amount});
}
