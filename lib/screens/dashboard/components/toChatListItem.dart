import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class ToChatListItem extends StatefulWidget {
  final String message;
  ToChatListItem({
    Key key,
    @required this.message,
  }) : super(key: key);
  @override
  _ToChatListItemState createState() => _ToChatListItemState();
}

class _ToChatListItemState extends State<ToChatListItem> {
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
        margin: EdgeInsets.only(bottom: sizer(false, 9, context)),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sizer(false, 13, context),
                          horizontal: sizer(true, 13, context)),
                      decoration: BoxDecoration(
                        color: Color(0xff2254D3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(widget.message,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: sizer(true, 14, context),
                              fontWeight: FontWeight.w500))),
                ),
              ),
              SizedBox(width: sizer(true, 5, context)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      'https://res.cloudinary.com/gorge/image/upload/v1592820243/Ellipse_25.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30)),
            ]));
  }
}
