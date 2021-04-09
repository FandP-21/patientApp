import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/models/digest.dart';

class DigestBox extends StatefulWidget {
  final DigestData digest;
  final GestureTapCallback onPressed;
  DigestBox({
    Key key,
    @required this.digest,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _DigestBoxState createState() => _DigestBoxState();
}

class _DigestBoxState extends State<DigestBox> {
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
        child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ),
            //       color: Color(0xff245DE8),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                  padding: EdgeInsets.only(bottom: sizer(false, 18, context)),
                  decoration: BoxDecoration(
                      //      color: Color(0xffffffff),
                      //   borderRadius: BorderRadius.circular(10.0),
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xffF3F4F8), width: 1.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.digest.title,
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: sizer(true, 16.0, context))),
                              Text(widget.digest.subText,
                                  style: TextStyle(
                                      color: Color(0xff868697),
                                      fontSize: sizer(true, 16.0, context))),
                              Text(widget.digest.author,
                                  style: TextStyle(
                                    color: Color(0xff071232),
                                    fontSize: sizer(true, 14, context),
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          )),
                      SizedBox(width: 42),
                      Image.asset(widget.digest.image,
                          fit: BoxFit.cover, width: 80, height: 80)
                    ],
                  )),
            )));
  }
}
