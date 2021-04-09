import 'package:flutter/material.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/components/whiteHeaderText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonWhite.dart';
import 'package:thcMobile/components/backButtonBlack.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/components/blackMenuTextField.dart';
import 'package:thcMobile/screens/dashboard/subscribeToPlan/findingAmbulance.dart';

class OneOffPlan extends StatefulWidget {
  OneOffPlan({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OneOffPlanState createState() => _OneOffPlanState();
}

class _OneOffPlanState extends State<OneOffPlan> {
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
      backgroundColor: Color(0xff071232),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: sizer(false, 50, context),
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BackButtonBlack(
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: sizer(false, 25, context)),
                    WhiteHeaderText(title: 'Request an ambulance'),
                    SizedBox(height: 5),
                    Text(
                      'Choose your preferred hospital',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizer(true, 16.0, context),
                      ),
                    ),
                    SizedBox(height: 26),
                    DropdownWidget(
                      title: 'Select hospital',
                      store: ['IFEDOC', 'ELONA', 'ELONAA'],
                      altColor: Color(0xff0C1941),
                      altDropdownColor: Color(0xff0C1941),
                      altTextColor: white,
                      altArrowColor: white,
                    ),
                    SizedBox(height: sizer(false, 10, context)),
                    BlackMenuTextfield(hintText: "Enter your address"),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: sizer(true, 20, context),
                      right: sizer(true, 20, context),
                    ),
                    child: ButtonWhite(
                      title: 'REQUEST & PAY NG 2,500',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FindingAmbulance(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
