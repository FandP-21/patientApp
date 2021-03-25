import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/store.dart';

class BackButtonBlack extends StatefulWidget {
  final GestureTapCallback onPressed;
  BackButtonBlack({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _BackButtonBlackState createState() => _BackButtonBlackState();
}

class _BackButtonBlackState extends State<BackButtonBlack> {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        ),
        color: white.withOpacity(0.2),
        child: GestureDetector(
          onTap: widget.onPressed ?? () => Navigator.pop(context),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
              decoration: BoxDecoration(
                //      color: Color(0xff1d2746),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ))),
        ));
  }
}
