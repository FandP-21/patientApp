import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/forums/forumChat.dart';

class MessageListItem extends StatefulWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final GestureTapCallback onPressed;
  MessageListItem(
      {Key key,
      @required this.name,
      @required this.message,
      @required this.unread,
      @required this.time,
      this.onPressed})
      : super(key: key);
  @override
  _MessageListItemState createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem> {
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
        ),
        child: GestureDetector(
          onTap: widget.onPressed ??
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForumChat(title: widget.name))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: sizer(false, 18, context)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network('https://thc2020.herokuapp.com/media/doctor_photo/process_3_t7oNy51.png',
                              fit: BoxFit.cover, width: 60, height: 60)),
                      SizedBox(width: width(15, false)),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(widget.name,
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: pixel16,
                                        fontWeight: FontWeight.w500)),
                                Text(widget.time,
                                    style: TextStyle(
                                        color: Color(0xff245DE8),
                                        fontSize: sizer(true, 14, context),
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            SizedBox(
                              height: sizer(false, 7, context),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: width(65, true, context),
                                  child: Text(
                                    widget.message,
                                    style: TextStyle(
                                      color: Color(0xff828A95),
                                      height: 1.5,
                                      fontWeight: FontWeight.w300,
                                      fontSize: sizer(true, 14, context),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: red,
                                  ),
                                  child: Text(widget.unread.toString(),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: pixel12,
                                        height: 1.1,
                                        fontWeight: semiBold,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
                  color: backgroundGrey,
                )
              ]),
        ),
      ),
    );
  }
}
