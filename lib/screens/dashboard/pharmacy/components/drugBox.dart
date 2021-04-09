import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class DrugBox extends StatefulWidget {
  DrugBox(
      {Key key,
      @required this.title,
      @required this.source,
      @required this.amount,
      @required this.onPressed})
      : super(key: key);
  final String title;
  final String source;
  final String amount;
  final Function onPressed;

  @override
  _DrugBoxState createState() => _DrugBoxState();
}

class _DrugBoxState extends State<DrugBox> {
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
        color: Color(0xffF3F4F8),
        child: GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/drugImage.png',
                          width: 55, height: 55, fit: BoxFit.contain)),
                  SizedBox(width: 10),
                  Column(
                    children: <Widget>[
                      Text(widget.title,
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 16.0, context))),
                      Text(widget.source,
                          style: TextStyle(
                              color: Color(0xff8E919C),
                              fontSize: sizer(true, 16.0, context))),
                    ],
                  ),
                  Spacer(),
                  Container(
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
            )));
  }
}
