import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class PriceBox extends StatefulWidget {
  PriceBox({
    Key key,
    @required this.title,
    @required this.amount,
    @required this.isService,
  }) : super(key: key);
  final String title;
  final bool isService;
  final String amount;

  @override
  _PriceBoxState createState() => _PriceBoxState();
}

class _PriceBoxState extends State<PriceBox> {
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
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.title,
              style: TextStyle(
                  color: Color(0xff071232),
                  fontSize: sizer(true, 16.0, context))),
          widget.isService
              ? SizedBox()
              : Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 14.6),
                  decoration: BoxDecoration(
                    color: Color(0xffDFE8FC),
                    borderRadius: BorderRadius.circular(14.6),
                  ),
                  child: Center(
                      child: Text(widget.amount,
                          style: TextStyle(
                              color: Color(0xff2254D3),
                              fontSize: sizer(true, 14, context)))),
                )
        ],
      ),
    );
  }
}
