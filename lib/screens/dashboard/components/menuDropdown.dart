import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class MenuDropdown extends StatefulWidget {
  MenuDropdown({Key key, @required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final GestureTapCallback onPressed;

  @override
  _MenuDropdownState createState() => _MenuDropdownState();
}

class _MenuDropdownState extends State<MenuDropdown> {
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
            //       color: Color(0xff245DE8),
            child: GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border(
                      //     bottom: BorderSide(
                      //         color: Color(0xffF3F4F8), width: 1.0))
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.title,
                              style: TextStyle(
                                  color: Color(0xff2254D3),
                                  fontSize: sizer(true, 16.0, context))),
                          Icon(Icons.keyboard_arrow_down,
                              size: 20, color: Color(0xff2254D3))
                        ])))));
  }
}
