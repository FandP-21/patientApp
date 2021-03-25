import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/styles.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/screens/dashboard/healthPlans/selectHmo.dart';
// import 'package:thcMobile/screens/dashboard/medHub/components/hmo.dart';
import 'package:thcMobile/screens/dashboard/medHub/components/hospitals.dart';
import 'package:thcMobile/screens/dashboard/medHub/components/dignosticCentre.dart';

class MedHub extends StatefulWidget {
  MedHub({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MedHubState createState() => _MedHubState();
}

class _MedHubState extends State<MedHub> {
  @override
  void initState() {
    super.initState();
  }

  List<ArticleWidget> articles = [
    ArticleWidget(
      title: 'Your Dental health & you.',
    ),
    ArticleWidget(
      title: '12 healthy food options for diabetics.',
    ),
    ArticleWidget(
      title: 'Your Dental health & you.',
    ),
    ArticleWidget(
      title: '12 healthy food options for diabetics.',
    ),
  ];
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: sizer(false, 15, context)),
                    HeaderText(title: 'MedHub'),
                    SizedBox(height: 30),
                    SearchTextInput(
                      hintText: 'Search',
                      onChanged: (text) {},
                    ),
                    SizedBox(height: sizer(false, 20, context)),
                    Text(
                      'Articles',
                      style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 20, context),
                      ),
                    ),
                    SizedBox(
                      height: sizer(false, 15, context),
                    ),
                    new GridView.count(
                      crossAxisCount: 2,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: articles.map((ArticleWidget item) {
                        return articleBox(
                          item.title,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: sizer(false, 15, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlueButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SelectHospital(),
                              ),
                            );
                          },
                          title: "Hospitals",
                        ),
                        BlueButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DiagnosticCentre(),
                              ),
                            );
                          },
                          title: "Pharmacy",
                        ),
                        BlueButton(
                          onPressed: null,
                          title: "Drugs",
                        ),
                        BlueButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SelectHmo(),
                              ),
                            );
                          },
                          title: "Hmos",
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: roundedF3Box,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Color(0xffdfe8fc)),
                            child: Center(
                                child: Image.asset(
                                    'assets/images/symptomIcon.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain)),
                          ),
                          SizedBox(height: 9),
                          Text('Symptom checker',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 20, context))),
                          Text(
                              'This is a simple Leads detail page with creation form, calendar view.',
                              style: TextStyle(
                                  color: Color(0xff8E919C),
                                  fontSize: sizer(true, 16.0, context)))
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget articleBox(String title) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage('assets/images/articleImage.png'),
            fit: BoxFit.contain),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: sizer(true, 18, context),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class ArticleWidget {
  String title;
  ArticleWidget({
    @required this.title,
  });
}

class BlueButton extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  BlueButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _BlueButtonState createState() => _BlueButtonState();
}

class _BlueButtonState extends State<BlueButton> {
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
    return Material(
      //   elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        // side: BorderSide(color: Colors.red)
      ),
      color: Color(0xff245DE8),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
          decoration: BoxDecoration(
            //   color: Color(0xff245DE8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: sizer(true, 16.0, context),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
