import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({this.photo, this.name});
  final String photo, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 20, bottom: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(photo),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.50,
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                      color: deepGreen,
                      fontWeight: FontWeight.w400,
                      fontSize: largeText,
                    ),
                  ),
                  Text(
                    "Requested a conversation",
                    style: TextStyle(
                      color: defaultBlack,
                      fontWeight: FontWeight.w300,
                      fontSize: smallText,
                    ),
                  )
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: defaultGreen,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.check,
                color: white,
                size: 22
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.close,
                color: white,
                size: 22
              ),
            )
          ],
        ),
      ),
      onTap: null,
    );
  }
}
