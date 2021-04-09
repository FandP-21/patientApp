import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class HmoBox extends StatefulWidget {
  final String name;
  final String amount;
  final String renewDate, type;
  final String expired;
  HmoBox(
      {Key key,
      @required this.name,
      @required this.amount,
      @required this.type,
      @required this.expired,
      @required this.renewDate})
      : super(key: key);
  @override
  _HmoBoxState createState() => _HmoBoxState();
}

class _HmoBoxState extends State<HmoBox> {
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
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 139,
                margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                decoration: BoxDecoration(
                  color: Color(0xffF3F4F8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset('assets/images/hmoLogo.png',
                                  width: 48, height: 48)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 9),
                            decoration: BoxDecoration(
                                color: Color(0xffDFE8FC),
                                borderRadius: BorderRadius.circular(14.6)),
                            child: Text(
                              "NGN ${widget.amount}/${widget.type}",
                              style: TextStyle(
                                  color: Color(0xff2254D3),
                                  fontSize: sizer(true, 14, context)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Color(0xff071232),
                            fontSize: sizer(true, 20, context)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.expired != 'expired'
                            ? 'Renews ' + widget.renewDate
                            : 'Expired',
                        style: TextStyle(
                            color: Color(0xff8E919C),
                            fontSize: sizer(true, 16.0, context)),
                      )
                    ]))));
  }
}
