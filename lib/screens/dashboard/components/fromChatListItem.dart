import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';

class FromChatListItem extends StatefulWidget {
  final String message;
  FromChatListItem({
    Key key,
    @required this.message,
  }) : super(key: key);
  @override
  _FromChatListItemState createState() => _FromChatListItemState();
}

class _FromChatListItemState extends State<FromChatListItem> {
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      'https://res.cloudinary.com/gorge/image/upload/v1592820243/Ellipse_25.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30)),
              SizedBox(width: sizer(true, 5, context)),
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sizer(false, 13, context),
                          horizontal: sizer(true, 13, context)),
                      decoration: BoxDecoration(
                        color: Color(0xffDFE8FC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(widget.message,
                          style: TextStyle(
                              color: Color(0xff364354),
                              fontSize: sizer(true, 14, context),
                              fontWeight: FontWeight.w500))),
                ),
              )
            ]));
  }
}
