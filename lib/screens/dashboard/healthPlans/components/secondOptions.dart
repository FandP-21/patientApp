import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import './optionItem.dart';

class SecondOptions extends StatefulWidget {
  SecondOptions(
      {Key key,
      this.title,
      @required this.onPressedA,
      @required this.onPressedB})
      : super(key: key);
  final String title;
  final GestureTapCallback onPressedA;
  final GestureTapCallback onPressedB;

  @override
  _SecondOptionsState createState() => _SecondOptionsState();
}

class _SecondOptionsState extends State<SecondOptions> {
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
    return SafeArea(
        child: Container(
            child: new SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            OptionItem(
                hasPadding: false,
                onPressed: widget.onPressedA,
                title: 'Retail Health Plans'),
            SizedBox(height: sizer(false, 15, context)),
            OptionItem(
                hasPadding: false,
                onPressed: widget.onPressedB,
                title: 'EasyCare affordable healthcare'),
          ]),
    )));
  }
}
