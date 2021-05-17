import 'package:flutter/material.dart';
import 'package:thcMobile/components/decorationBox.dart';
import 'package:thcMobile/components/emptyData.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/moreButton.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/models/pharmacy.dart';
import 'buyMedication.dart';

List selectedDrugs = [];
List drugIds = [];

class MedicationDetails extends StatefulWidget {
  MedicationDetails({
    this.title,
    @required this.prescription,
  });

  final String title;
  final List<dynamic> prescription;

  @override
  _MedicationDetailsState createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title = " ";

  @override
  void initState() {
    super.initState();
    selectedDrugs = [];
    drugIds = [];
    print(widget.prescription);
  }

  void addDrugs(e) {
    selectedDrugs.add(e);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar:  widget.prescription.length > 0
          ? Container(
        height: 50,
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: ButtonBlue(
            title: "SEARCH DRUG",
            onPressed: () {
              if (selectedDrugs.length == 0)
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Please select at least one drug",
                        style: TextStyle(
                          fontSize: sizer(true, 15.0, context),
                          color: Colors.white,
                        ))));
              else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuyMedication(
                          drugs: selectedDrugs,
                          drugIds: drugIds,
                          title: '',
                        )));
            }),
      )
          : SizedBox(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(
                top: sizer(false, 50, context),
                left: sizer(true, 20, context),
                bottom: 30,
                right: sizer(true, 20, context)),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BackButtonWhite(
                          onPressed: () {},
                        ),
                        MoreButton(onPressed: () => Navigator.pop(context))
                      ],
                    ),
                    SizedBox(height: sizer(false, 20, context)),
                    HeaderText(title: widget.title),
                    SizedBox(height: sizer(false, 7, context)),
                    RichText(
                      text: TextSpan(
                        text: 'Prescribed by ',
                        style: TextStyle(
                            color: Color(0xff828A95),
                            fontSize: sizer(true, 14, context)),
                        children: <TextSpan>[
                          TextSpan(
                              text: "a doctor",
                              style: TextStyle(color: Color(0xff245de8))),
                          TextSpan(
                            text: ' on ' + "date",
                            style: TextStyle(
                              color: Color(0xff828A95),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Text('Drugs',
                        style: TextStyle(
                            color: Color(0xff071232),
                            fontSize: sizer(true, 20, context))),
                    SizedBox(height: 30),
                    widget.prescription.length > 0
                        ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.prescription.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: sizer(false, 19, context)),
                                child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    color: Color(0xffF3F4F8),
                                    child: DrugWidget(
                                      dosage: widget.prescription[index]
                                          ['dosage'],
                                      unit: widget.prescription[index]['unit'],
                                      title: 'Remdesiver',
                                      id: widget.prescription[index]['id'],
                                      frequency: widget.prescription[index]
                                          ['frequency'],
                                      noOfTablets: widget.prescription[index]
                                          ['no_of_tablets'],
                                    )),
                              );
                            },
                          )
                        : EmptyData(
                            title: "No prescriptions currently",
                            isButton: false),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrugWidget extends StatefulWidget {
  final String title;
  final String dosage;
  final String frequency;
  final String unit;
  final int id;
  final PharmacyDrug pharmacyDrug;
  final String noOfTablets;

  DrugWidget(
      {@required this.title,
      @required this.unit,
      @required this.dosage,
      this.id,
      this.frequency,
      this.noOfTablets,
      this.pharmacyDrug});

  @override
  _DrugWidgetState createState() => _DrugWidgetState();
}

class _DrugWidgetState extends State<DrugWidget> {
  bool _open = false;

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
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xffF3F4F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${widget.title}  (${widget.dosage} ${widget.unit})",
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 20, context))),
                ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Color(0xffDFE8FC),
                      child: _open
                          ? Icon(Icons.expand_less,
                              size: 19, color: Color(0xff2254D3))
                          : Icon(Icons.expand_more,
                              size: 19, color: Color(0xff2254D3)),
                    )),
              ],
            ),
            _open ? SizedBox(height: 22) : Container(),
            _open
                ? Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Color(0xffDFE8FC),
                    ),
                  )
                : Container(),
            _open ? SizedBox(height: 22) : Container(),
            _open
                ? Text(
                    'Dosage',
                    style: TextStyle(fontSize: 15, color: Color(0xff8E919C)),
                  )
                : Container(),
            _open
                ? Text(
                    "${widget.noOfTablets} spoons, 3 times ${widget.frequency} for 7 days",
                    style: TextStyle(
                        color: Color(0xff2254D3),
                        fontSize: sizer(true, 16.0, context)),
                  )
                : Container(),
            _open ? SizedBox(height: 48) : Container(),
            _open
                ? DecorationBox(
                    title: 'SELECT DRUG',
                    onPressed: () {
                      selectedDrugs.add(widget.title);
                      drugIds.add(1);
                    })
                : Container(),
          ],
        ),
      ),
      onTap: () {
        if (_open == true) {
          setState(() {
            _open = false;
          });
        } else {
          setState(() {
            _open = true;
          });
        }
        print(_open);
      },
    );
  }
}
