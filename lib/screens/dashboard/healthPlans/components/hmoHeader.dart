import 'package:flutter/material.dart';
import 'package:thcMobile/components/plusButton.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class HmoHeader extends StatefulWidget {
  final String hmoNo;
  final Function onPressed;
  HmoHeader({Key key, @required this.hmoNo, @required this.onPressed})
      : super(key: key);
  @override
  _HmoHeaderState createState() => _HmoHeaderState();
}

class _HmoHeaderState extends State<HmoHeader> {
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
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.hmoNo,
          style: TextStyle(
              color: Color(0xff071232), fontSize: sizer(true, 16, context)),
        ),
        PlusButton(onPressed: widget.onPressed),
      ],
    );
  }
}
