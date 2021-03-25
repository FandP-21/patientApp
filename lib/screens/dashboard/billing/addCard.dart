import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/authTextInput.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Add card'),
                        SizedBox(height: 28),
                        new Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: customForm(),
                        )
                      ]),
                )))));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthTextInput(hintText: 'Card Number', onChanged: (text) {}),
        ),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child:
                        AuthTextInput(hintText: 'MM/YY', onChanged: (text) {})),
                SizedBox(width: 16.0),
                Expanded(
                  child: AuthTextInput(hintText: 'CVV', onChanged: (text) {}),
                )
              ],
            )),
        ButtonBlue(onPressed: () {}, title: 'ADD CARD'),
      ],
    );
  }
}
