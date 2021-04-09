import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class GreenMeterBox extends StatefulWidget {
  final double position;
  GreenMeterBox({
    Key key,
    @required this.position,
  }) : super(key: key);
  @override
  _GreenMeterBoxState createState() => _GreenMeterBoxState();
}

class _GreenMeterBoxState extends State<GreenMeterBox> {
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 13,
      margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * widget.position),
        child: Container(
          height: 13,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xff22D389),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
