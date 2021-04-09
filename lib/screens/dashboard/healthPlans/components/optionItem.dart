import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class OptionItem extends StatefulWidget {
  final String title;
  final bool hasPadding;
  final GestureTapCallback onPressed;
  OptionItem({
    Key key,
    @required this.title,
    @required this.hasPadding,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
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
      height: 50,
      margin: widget.hasPadding
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(bottom: 0),
      child: Center(
          child: Material(
              color: Color(0xffF3F4F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.title,
                            style: TextStyle(
                                color: Color(0xff071232),
                                fontSize: sizer(true, 14, context),
                                fontWeight: FontWeight.w500)),
                        Material(
                          color: Color.fromRGBO(34, 84, 211, 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(34, 84, 211, 0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Icon(Icons.arrow_forward,
                                      size: 17, color: Color(0xff2254D3))),
                            ),
                          ),
                        ),
                      ],
                    )),
              ))),
    );
  }
}
