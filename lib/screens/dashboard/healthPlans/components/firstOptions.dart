import 'package:flutter/material.dart';
import './optionItem.dart';

class FirstOptions extends StatefulWidget {
  FirstOptions(
      {Key key,
      this.title,
      @required this.onPressedA,
      @required this.onPressedB})
      : super(key: key);
  final String title;
  final GestureTapCallback onPressedA;
  final GestureTapCallback onPressedB;

  @override
  _FirstOptionsState createState() => _FirstOptionsState();
}

class _FirstOptionsState extends State<FirstOptions> {
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
    return Expanded(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptionItem(
                    hasPadding: false,
                    onPressed: widget.onPressedA,
                    title: 'I already have an existing plan'),
                SizedBox(height: 10),
                OptionItem(
                    hasPadding: false,
                    onPressed: widget.onPressedB,
                    title: "I\'d like to register for a health plan"),
              ],
            ),
            SizedBox(height: 300),
          ]),
    );
  }
}
